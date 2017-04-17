# -*- encoding : utf-8 -*-
module BingAdsApi
	class Bulk < BingAdsApi::Service
		def download_campaigns_by_account_ids(account_ids, entities, campaign_types = [ BingAdsApi::CampaignType::SEARCH_AND_CONTENT ])
			response = call(:download_campaigns_by_account_ids, 
				{ account_ids: { 'ins0:long' => account_ids },
          entities: entities,
          format_version: '4.0',
          campaign_type: campaign_types
        }
      )
			response_hash = get_response_hash(response, __method__)
    end

    def download_campaigns_by_campaign_ids(account_id, campaign_ids, entities)
      campaigns = campaign_ids.map do |campaign_id|
        {
          campaign_scope: {
            campaign_id: campaign_id,
            parent_account_id: account_id
          }
        }
      end
      response = call(:download_campaigns_by_campaign_ids,
        { campaigns: campaigns,
          entities: entities,
          format_version: '4.0',
        }
      )
			response_hash = get_response_hash(response, __method__)
    end

    def get_bulk_download_status(request_id)
      response = call(:get_bulk_download_status, { request_id: request_id })
      response_hash = get_response_hash(response, __method__)
			report_request_status = BingAdsApi::DownloadRequestStatus.new(response_hash)
			return report_request_status
    end


    def get_bulk_upload_url(account_id)
      response = call(:get_bulk_upload_url, { account_id: account_id })
			response_hash = get_response_hash(response, __method__)
      return BingAdsApi::BulkUploadUrl.new(response_hash)
    end

    def get_bulk_upload_status(request_id)
      response = call(:get_bulk_upload_status, { request_id: request_id })
			response_hash = get_response_hash(response, __method__)
      return BingAdsApi::BulkUploadStatus.new(response_hash)
    end

    def bulk_upload(account_id, data_io)
      url_info = get_bulk_upload_url(account_id)
      resp = RestClient.post(url_info.upload_url,
        { payload: data_io },
        {
          multipart: true,
          content_type: 'multipart/form-data',
          'DeveloperToken' => self.client_proxy.developer_token,
          'CustomerAccountId' => self.client_proxy.account_id,
          'CustomerId' => self.client_proxy.customer_id,
          'UserName' => self.client_proxy.username,
          'Password' => self.client_proxy.password,
        }
      )
      resp
    end

		private
    def get_service_name
      "bulk"
    end
  end

end


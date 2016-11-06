# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public: Define a keyword
	#
	# Author:: alex.cavalli@offers.com
	#
	# Examples
	#   keyword = BingAdsApi::Keyword.new(
	#     :bid => BingAdsApi::Bid.new(:amount => 1.23),
	#     :destination_url => "http://www.example.com/",
	#     :id => 123456789,
	#     :match_type => BingAdsApi::Keyword::EXACT,
	#     :param1 => "param1",
	#     :param2 => "param2",
	#     :param3 => "param3",
	#     :status => BingAdsApi::Keyword::ACTIVE,
	#     :text => "keyword text")
	#   # => <BingAdsApi::Keyword>
	class Keyword < BingAdsApi::DataObject
		include BingAdsApi::KeywordEditorialStatuses
		include BingAdsApi::KeywordStatuses
		include BingAdsApi::MatchTypes


		attr_accessor :bid,
			:destination_url,
      :final_urls,
      :tracking_url_template,
      :url_custom_parameters,
			:editorial_status,
			:forward_compatibility_map,
			:id,
			:match_type,
			:param1,
			:param2,
			:param3,
			:status,
			:text

    def to_hash(keys = :underscore)
      hash = super(keys)

      if self.final_urls.present?
        final_urls_key = get_attribute_key('final_urls', keys)
        hash[final_urls_key] = { "string" => self.final_urls }
      end

      if self.url_custom_parameters.present?
        params = self.url_custom_parameters.map do |k, v|
          kk = get_attribute_key('key', keys)
          vk = get_attribute_key('value', keys)
          { kk => k, vk => v }
        end
        param_key = get_attribute_key('parameters', keys)
        custom_param_key = get_attribute_key('custom_parameter', keys)
        url_custom_parameters_key = get_attribute_key('url_custom_parameters', keys)
        hash[url_custom_parameters_key] = {
          param_key => { custom_param_key => params }
        }
      end

      hash
    end

		private

			# Internal: Retrieve the ordered array of keys corresponding to this data
			# object.
			#
			# Author: alex.cavalli@offers.com
			def get_key_order
				super.concat(BingAdsApi::Config.instance.
					campaign_management_orders['keyword'])
			end

	end
end

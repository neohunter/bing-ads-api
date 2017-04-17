module BingAdsApi
  class BulkUploadStatus < BingAdsApi::DataObject
    REQUEST_STATUS = BingAdsApi::Config.instance.
      bulk_constants['request_status_type']
    attr_accessor :result_file_url, :request_status
    alias_method :status, :request_status

    def completed?
      return (request_status == REQUEST_STATUS['completed'] or
              request_status == REQUEST_STATUS['completed_with_errors'])
    end
    alias_method :success?, :completed?


    def in_progress?
      return (request_status == REQUEST_STATUS['in_progress'] or
              request_status == REQUEST_STATUS['file_uploaded'] or
              request_status == REQUEST_STATUS['pending_file_upload'])
    end
    alias_method :pending?, :in_progress?

    def failed?
      return (request_status == REQUEST_STATUS['failed'] or
              request_status == REQUEST_STATUS['failed_full_sync_required'] or
              request_status == REQUEST_STATUS['completed_with_errors'])
    end
    alias_method :error?, :failed?
  end
end

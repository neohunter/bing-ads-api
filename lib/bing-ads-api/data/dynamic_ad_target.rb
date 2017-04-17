# -*- encoding : utf-8 -*-

module BingAdsAi
  class DynamicAdTarget < BingAdsApi::DataObject
    include BingAdsApi::MatchTypes
    include BingAdsApi::AdEditorialStatus
    include BingAdsApi::AdStatus
    include BingAdsApi::AdType

    attr_accessor :id, :editorial_status,
      :path1, :path2, :text, :status,
      :tracking_url_template, :final_urls,
      :type, :curl_custom_parameters

    def to_hash(keys = :underscore)
      has = super(keys)
      if self.final_urls.present?
        final_urls_key = get_attribute_key('final_urls', keys)
        hash[final_urls_key] = { 'string' => self.final_urls }
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

  end
end

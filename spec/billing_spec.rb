# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'pry'

# Author:: jlopezn@neonline.cl
describe BingAdsApi::Billing do

  let(:default_options) do
    {
      environment: :sandbox,
      username: "ruby_bing_ads_sbx",
      password: "sandbox123",
      developer_token: "BBD37VB98",
      customer_id: "21025739",
      account_id: "8506945"
    }
  end
  let(:service) { BingAdsApi::Billing.new(default_options) }

  it "should initialize with options" do
    new_service = BingAdsApi::Billing.new(default_options)
    expect(new_service).not_to be_nil
  end

  context '#get_insertion_orders_by_account' do
    it 'should get insertion orders' do
      service.get_insertion_orders_by_account
    end
  end

end

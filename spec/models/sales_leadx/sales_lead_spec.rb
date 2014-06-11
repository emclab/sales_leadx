require 'spec_helper'

module SalesLeadx
  describe SalesLead do
    it "should be OK" do
      l = FactoryGirl.build(:sales_leadx_sales_lead)
      l.should be_valid
    end
    
    it "should reject nil customer id" do
      l =  FactoryGirl.build(:sales_leadx_sales_lead, :customer_id => nil)
      l.should_not be_valid
    end
    
    it "should reject nil provider_id" do
      l = FactoryGirl.build(:sales_leadx_sales_lead, :provider_id => nil)
      l.should_not be_valid
    end
    
    it "should reject nil lead_info" do
      l = FactoryGirl.build(:sales_leadx_sales_lead, :lead_info => nil)
      l.should_not be_valid
    end
    
    it "should reject nil subject" do
      l = FactoryGirl.build(:sales_leadx_sales_lead, :subject => nil)
      l.should_not be_valid
    end
    
    it "should reject nil lead date" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_date: nil)
      i.should_not be_valid
    end
    
    it "should reject 0 lead_source_id" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_source_id: 0)
      i.should_not be_valid
    end
    
    it "should reject 0 lead_status_id" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_status_id: 0)
      i.should_not be_valid
    end
    
    it "should take nil lead_status_id" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_status_id: nil)
      i.should be_valid
    end
    
    it "should reject 0 lead_category_id" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_category_id: 0)
      i.should_not be_valid
    end
    
    it "should take nil lead_category_id" do
      i = FactoryGirl.build(:sales_leadx_sales_lead, lead_category_id: nil)
      i.should be_valid
    end
    
    it "should reject duplicate lead_info for the same customer_id" do
      i1 = FactoryGirl.create(:sales_leadx_sales_lead, lead_info: 'this is a lead info')
      i2 = FactoryGirl.build(:sales_leadx_sales_lead, lead_info: 'This Is A lEad INfo' )
      i2.should_not be_valid
    end
    
    it "should be OK for duplicate lead_info for different customer_id" do
      i1 = FactoryGirl.create(:sales_leadx_sales_lead, lead_info: 'this is a lead info')
      i2 = FactoryGirl.build(:sales_leadx_sales_lead, lead_info: 'This Is A lEad INfo', :customer_id => i1.customer_id + 1 )
      i2.should be_valid
    end
  end
end

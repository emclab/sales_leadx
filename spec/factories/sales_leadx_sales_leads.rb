# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sales_leadx_sales_lead, :class => 'SalesLeadx::SalesLead' do
    customer_id 1
    last_updated_by_id 1
    provider_id 1
    lead_info "MyText"
    contact_instruction "MyText"
    lead_status_id 1
    lead_eval "MyText"
    close_lead_by_id 1
    lead_source_id 1
    lead_quality_scale 1
    lead_accuracy_scale 1
    subject "MyString"
    lead_date "2013-10-13"
    initial_order_total 1
  end
end

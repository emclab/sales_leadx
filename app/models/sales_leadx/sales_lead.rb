module SalesLeadx
  class SalesLead < ActiveRecord::Base
    attr_accessor :customer_name, :lead_source_name, :sale_success_value, :close_lead_value, :lead_status_name
    
    attr_accessible :lead_eval, :contact_instruction, :customer_id, :last_updated_by_id, :lead_accuracy_scale, :lead_quality_scale, 
                    :lead_info, :sale_success, :lead_source_id, :lead_status_id, :provider_id, :subject, :lead_date, :provider_name_autocomplete,
                    :customer_name_autocomplete, :initial_order_total, :close_lead_by_id,
                    :customer_name, :lead_source_name, :sale_success_value, :close_lead_value,
                    :as => :role_new
    attr_accessible :lead_eval, :contact_instruction, :last_updated_by_id, :lead_accuracy_scale, :lead_quality_scale, :close_lead, :lead_date,
                    :close_lead_date, :close_lead_by_id, :lead_info, :sale_success, :lead_source_id, :provider_id, :subject, :lead_status_id,
                    :provider_name_autocomplete, :customer_name_autocomplete, :customer_name, :initial_order_total, :close_lead_by_id, 
                    :customer_name, :lead_source_name, :sale_success_value, :close_lead_value, :lead_status_name,
                    :as => :role_update 
                    
    attr_accessor :customer_id_s, :start_date_s, :end_date_s, :zone_id_s, :sales_id_s, :lead_source_id_s, :lead_status_s
    attr_accessible :customer_id_s, :start_date_s, :end_date_s,:zone_id_s, :sales_id_s, :lead_source_id_s, :lead_status_s,
                    :as => :role_search_stats                
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :provider, :class_name => 'Authentify::User'
    belongs_to :close_lead_by, :class_name => 'Authentify::User'
    has_many :logs, :class_name => "Commonx::Log"
    belongs_to :customer, :class_name => SalesLeadx.customer_class.to_s
    belongs_to :lead_source, :class_name => 'Commonx::MiscDefinition'
    belongs_to :lead_status, :class_name => 'Commonx::MiscDefinition'
    
    validates :lead_info, :subject, :lead_date, :presence => true
    validates :customer_id, :provider_id, :lead_source_id, :lead_status_id, :presence => true, :numericality => {:greater_than => 0}
    validates :lead_info, :uniqueness => {:scope => :customer_id, :case_sensitive => false, :message => I18n.t('Duplicate Lead Info!')}
    
    def customer_name_autocomplete
      self.customer.try(:name)
    end

    def customer_name_autocomplete=(name)
      self.customer = SalesLeadx.customer_class.find_by_name(name) if name.present?
    end
    
    def provider_name_autocomplete
      self.provider.try(:name)
    end

    def provider_name_autocomplete=(name)
      self.provider = Authentify::User.find_by_name(name) if name.present?
    end
    
  end
end

require_dependency "sales_leadx/application_controller"

module SalesLeadx
  class SalesLeadsController < ApplicationController
    before_filter :require_employee
    before_filter :load_customer
    
    helper_method :lead_sources, :lead_status
    
   def index
      @title= "销售线索"
      @sales_leads = params[:sales_leadx_sales_leads][:model_ar_r]
      @sales_leads = @sales_leads.where(:customer_id => @customer.id) if @customer
      @sales_leads = @sales_leads.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('sales_lead_index_view', 'sales_leadx')
    end
  
    def new
      @title= "新销售线索"
      @sales_lead = SalesLeadx::SalesLead.new()
    end
  
    def create
      @sales_lead = SalesLeadx::SalesLead.new(params[:sales_lead], :as => :role_new)
      @customer = SalesLeadx.customer_class.find_by_id(params[:sales_lead][:customer_id]) if params[:sales_lead].present? && params[:sales_lead][:customer_id].present?
      unless @customer
        cust = SalesLeadx.customer_class.find_by_name(@sales_lead.customer_name_autocomplete) if @sales_lead.customer_name_autocomplete.present?
        @sales_lead.customer_id = cust.id if cust.present?
      end
      #provider id from autocomplete
      provider = Authentify::User.find_by_name(@sales_lead.provider_name_autocomplete) if @sales_lead.provider_name_autocomplete.present?
      @sales_lead.provider_id = provider.id if provider.present?
      @sales_lead.last_updated_by_id = session[:user_id]
      if @sales_lead.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash.now[:error] = t('Data Error. Not Saved!')
        render 'new'
      end

    end
  
    def edit
      @title= "更新销售线索"      
      @sales_lead = SalesLeadx::SalesLead.find_by_id(params[:id])
    end
  
    def update
      @sales_lead = SalesLeadx::SalesLead.find_by_id(params[:id])
      #provider id from autocomplete
      provider = Authentify::User.find_by_name(@sales_lead.provider_name_autocomplete) if @sales_lead.provider_name_autocomplete.present?
      @sales_lead.provider_id = provider.id if provider.present?
      @sales_lead.last_updated_by_id = session[:user_id]
      params[:sales_lead][:initial_order_total] = '' if params[:sales_lead][:sale_success] == 'false'
      if @sales_lead.update_attributes(params[:sales_lead], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash.now[:error] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title= "销售线索内容"
      #nested with customer
      @sales_lead = SalesLeadx::SalesLead.find_by_id(params[:id])
      @erb_code = find_config_const('sales_lead_show_view', 'sales_leadx')
    end
    
    protected
        
    def lead_sources
      Commonx::MiscDefinition.where(:for_which => 'sales_lead_source').where(:active => true).order("ranking_index")
    end
    
    def lead_status
      Commonx::MiscDefinition.where(:for_which => 'sales_lead_status').where(:active => true).order('ranking_index')
    end
    
    def load_customer
      @customer = SalesLeadx.customer_class.find_by_id(params[:customer_id]) if params[:customer_id].present?
      @customer = SalesLeadx.customer_class.find_by_id(SalesLeadx::SalesLead.find_by_id(params[:id]).customer_id) if params[:id].present?
    end
    
  end
end

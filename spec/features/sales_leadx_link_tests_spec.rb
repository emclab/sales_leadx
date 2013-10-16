require 'spec_helper'

describe "LinkTests" do
  before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      config = FactoryGirl.create(:engine_config, :engine_name => 'customer_comm_recordx', :engine_version => nil, :argument_name => 'contact_via', :argument_value => 'phone, email, fax, meeting')
      qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'customer_qs')
      add = FactoryGirl.create(:kustomerx_address)
      #ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      cate = FactoryGirl.create(:commonx_misc_definition, :for_which => 'customer_status', :name => 'order category')
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ua9 = FactoryGirl.create(:user_access, :action => 'update_customer_comm_category', :resource => 'customerx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua10 = FactoryGirl.create(:user_access, :action => 'create_customer_comm_category', :resource => 'customerx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua5 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sales_leadx_sales_leads', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua6 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sales_leadx_sales_leads', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua7 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sales_leadx_sales_leads', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua8 = FactoryGirl.create(:user_access, :action => 'show', :resource => 'sales_leadx_sales_leads', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua25 = FactoryGirl.create(:user_access, :action => 'create_sales_lead', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua26 = FactoryGirl.create(:user_access, :action => 'index_sales_lead', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Commonx::Log.where('commonx_logs.sales_lead_id > ?', 0)")      
      ua16 = FactoryGirl.create(:user_access, :action => 'index_sales_lead_source', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Commonx::MiscDefinition.
                     where(:active => true).order('ranking_index')")
      ua = FactoryGirl.create(:user_access, :action => 'index_customer_status', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Commonx::MiscDefinition.
                     where(:active => true).order('ranking_index')")
      ua152 = FactoryGirl.create(:user_access, :action => 'index_quality_system', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Commonx::MiscDefinition.
                     where(:active => true).order('ranking_index')")
      ua1 = FactoryGirl.create(:user_access, :action => 'update_customer_status', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua17 = FactoryGirl.create(:user_access, :action => 'update_customer_status', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua18 = FactoryGirl.create(:user_access, :action => 'create_customer_status', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua19 = FactoryGirl.create(:user_access, :action => 'update_quality_system', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua20 = FactoryGirl.create(:user_access, :action => 'create_quality_system', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua21 = FactoryGirl.create(:user_access, :action => 'update_sales_lead_source', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ua22 = FactoryGirl.create(:user_access, :action => 'create_sales_lead_source', :resource => 'commonx_misc_definitions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur], :login => 'thistest', :password => 'password', :password_confirmation => 'password')
      lsource = FactoryGirl.create(:commonx_misc_definition, :for_which => 'sales_lead_source')
      @cate2 = FactoryGirl.create(:commonx_misc_definition, :for_which => 'customer_status', :name => 'newnew cate', :last_updated_by_id => @u.id)
      @cust = FactoryGirl.create(:kustomerx_customer, :zone_id => z.id, :sales_id => @u.id, :last_updated_by_id => @u.id, :quality_system_id => qs.id, :address => add)
      @slead = FactoryGirl.create(:sales_leadx_sales_lead, :provider_id => @u.id, :last_updated_by_id => @u.id, :customer_id => @cust.id, :lead_source_id => lsource.id, :lead_date => Date.today)
      @ccate1 = FactoryGirl.create(:commonx_misc_definition, :for_which => 'customer_status', :name => 'new', :active => true, :last_updated_by_id => @u.id)
      @ccate2 = FactoryGirl.create(:commonx_misc_definition, :for_which => 'quality_system', :name => 'nnew', :active => true, :last_updated_by_id => @u.id)
      @payment_terms_config = FactoryGirl.create(:engine_config, :engine_name => 'kustomerx', :engine_version => nil, :argument_name => 'customer_index_view', 
                              :argument_value => Authentify::AuthentifyUtility.find_config_const('customer_index_view', 'customerx')) 
      @payment_terms_config = FactoryGirl.create(:engine_config, :engine_name => 'customer_comm_recordx', :engine_version => nil, :argument_name => 'customer_comm_record_index_view', 
                              :argument_value => Authentify::AuthentifyUtility.find_config_const('cusotmer_comm_record_index_view', 'customerx')) 
      @payment_terms_config = FactoryGirl.create(:engine_config, :engine_name => 'customer_comm_recordx', :engine_version => nil, :argument_name => 'customer_comm_record_log_index_view', 
                              :argument_value => Authentify::AuthentifyUtility.find_config_const('customer_comm_record_log_index_view', 'customerx')) 
      
      @payment_terms_config = FactoryGirl.create(:engine_config, :engine_name => 'kustomerx', :engine_version => nil, :argument_name => 'customer_show_view', 
                              :argument_value => Authentify::AuthentifyUtility.find_config_const('customer_show_view', 'customerx')) 
      @payment_terms_config = FactoryGirl.create(:engine_config, :engine_name => 'customer_comm_recordx', :engine_version => nil, :argument_name => 'customer_comm_record_show_view', 
                              :argument_value => Authentify::AuthentifyUtility.find_config_const('cusotmer_comm_record_show_view', 'customerx')) 
                                                                           
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    
    
  describe "GET /sales_leadx_link_tests" do
    it "should display index customer's sales leads page" do
      visit sales_leads_path
      page.body.should have_content('Sales Leads')
    end
    
    it "should work with all links in sales leads index page" do
      visit sales_leads_path
      #save_and_open_page
      click_link 'Edit'
      visit sales_leads_path
      click_link @slead.id.to_s
      #visit customer_sales_leads_path(@cust)
      #click_link 'Back'
      visit sales_leads_path
      click_link '输入Leads'
    end
    
    it "should display index for sales lead without customer" do
      visit sales_leads_path
      page.body.should have_content('Sales Leads')
    end
    
    it "should display new sales leads page" do
      visit new_sales_lead_path
      page.body.should have_content('New Sales Lead')
    end
    
    it "should display edit sales leads page" do
      visit edit_sales_lead_path(@slead)
      page.body.should have_content('Edit Sales Lead')    
    end
    
    it "should show sales leads" do
      visit sales_lead_path(@slead)
      page.body.should have_content('Sales Lead Info')
    end
    
    it "should work with link on show sales lead page" do
      visit sales_leads_path
      #save_and_open_page
      click_link @slead.id.to_s 
      #save_and_open_page     
      click_link '新Log'
      #save_and_open_page
      page.should have_content('Log')
    end
  end
end

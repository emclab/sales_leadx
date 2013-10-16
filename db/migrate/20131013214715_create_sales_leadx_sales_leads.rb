class CreateSalesLeadxSalesLeads < ActiveRecord::Migration
  def change
    create_table :sales_leadx_sales_leads do |t|
      t.integer :customer_id
      t.integer :last_updated_by_id
      t.integer :provider_id
      t.text :lead_info
      t.text :contact_instruction
      t.integer :lead_status_id
      t.text :lead_eval
      t.boolean :sale_success
      t.boolean :close_lead
      t.integer :close_lead_by_id
      t.integer :lead_source_id
      t.integer :lead_quality_scale
      t.integer :lead_accuracy_scale
      t.string :subject
      t.date :lead_date
      t.integer :initial_order_total

      t.timestamps
    end
    
    add_index :sales_leadx_sales_leads, :customer_id
    add_index :sales_leadx_sales_leads, :provider_id
    add_index :sales_leadx_sales_leads, :subject
    add_index :sales_leadx_sales_leads, :lead_date
  end
end

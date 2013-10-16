require "sales_leadx/engine"

module SalesLeadx
  mattr_accessor :customer_class
  
  def self.customer_class
    @@customer_class.constantize
  end
end

class Address < ActiveRecord::Base
  belongs_to :customer

  def customerName
  	if self.customer.blank?
  		return '--'
  	end

  	self.customer.name
  end
end

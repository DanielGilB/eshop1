class OrderItem < ActiveRecord::Base
	belongs_to :order
 	belongs_to :disc

  def validate
    errors.add(:amount, "Debe ser uno o más") unless amount.nil? || amount > 0
    errors.add(:price, "Debe ser un número positivo") unless price.nil? || price > 0.0
end

class OrderItem < ActiveRecord::Base
<<<<<<< HEAD
  belongs_to :order
  belongs_to :disc

  def validate
    errors.add(:amount, "should be one or more") unless amount.nil? || amount > 0
    errors.add(:price, "should be a positive number") unless price.nil? || price > 0.0
  end
=======
	belongs_to :order
 	belongs_to :disc

  def validate
    errors.add(:amount, "Debe ser uno o más") unless amount.nil? || amount > 0
    errors.add(:price, "Debe ser un número positivo") unless price.nil? || price > 0.0
>>>>>>> 418e4e7b4d1fce0f538e2fd8afb251d783b33877
end

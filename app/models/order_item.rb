class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :disc

  def validate
    errors.add(:amount, "Debe de ser uno o más") unless amount.nil? || amount > 0
    errors.add(:price, "Debe de ser un número positivo") unless price.nil? || price > 0.0
  end
end

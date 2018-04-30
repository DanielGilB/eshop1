class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :discs, :through => :cart_items

  def add(disc_id)
    items = cart_items.where(disc_id: disc_id)
    disc = Disc.find disc_id
    if items.size < 1
      ci = cart_items.create :disc_id => disc_id, :amount => 1, :price => disc.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(disc_id)
    ci = cart_items.where(disc_id: disc_id).first
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end

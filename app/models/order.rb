class Order < ActiveRecord::Base
  require "active_merchant/billing/rails"

  attr_accessor :card_type, :card_number, :card_expiration_month, :card_expiration_year,             
                :card_verification_value

  has_many :order_items
  has_many :discs, :through => :order_items

  validates_presence_of :order_items,
                        :message => '¡El carrito de la compra está vacio! ' +
                                    'Por favor añada al menos un articulo antes de realizar el pedido.'
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :phone_number, :in => 7..20

  validates_length_of :ship_to_first_name, :in => 2..255
  validates_length_of :ship_to_last_name, :in => 2..255
  validates_length_of :ship_to_address, :in => 2..255
  validates_length_of :ship_to_city, :in => 2..255
  validates_length_of :ship_to_postal_code, :in => 2..255
  validates_length_of :ship_to_country_code, :in => 2..255

  validates_length_of :customer_ip, :in => 7..15
  validates_inclusion_of :status, :in => %w(open processed closed failed)

  validates_inclusion_of :card_type, :in => ['Visa', 'MasterCard', 'American Express', 'Discover'], :on => :create
  validates_length_of :card_number, :in => 13..19, :on => :create
  validates_inclusion_of :card_expiration_month, :in => %w(1 2 3 4 5 6 7 8 9 10 11 12), :on => :create
  validates_inclusion_of :card_expiration_year, :in => %w(2013 2014 2015 2016 2017 2018), :on => :create
  validates_length_of :card_verification_value, :in => 3..4, :on => :create

  def total
    sum = 0
    order_items.each do |item|
      sum += item.price * item.amount
    end
    sum
  end

  def process
    begin
      raise 'Un pedido realizado no puede procesarse de nuevo' if self.closed?
      active_merchant_payment
    rescue => e
      logger.error("Order #{id} failed due to raised exception: #{e}.")
      self.error_message = "Exception raised: #{e}"
      self.status = 'failed'
    end
    save!
    self.processed?
  end

  def active_merchant_payment
    ActiveMerchant::Billing::Base.mode = :test
    ActiveMerchant::Billing::AuthorizeNetGateway.default_currency = 'EUR'
    ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device = STDERR   
    ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device.sync = true
    self.status = 'failed' # order status by default

    # the card verification value is also known as CVV2, CVC2, or CID
    creditcard = ActiveMerchant::Billing::CreditCard.new(
      :brand              => card_type,
      :number             => card_number,
      :month              => card_expiration_month,
      :year               => card_expiration_year,
      :verification_value => card_verification_value,
      :first_name         => ship_to_first_name,
      :last_name          => ship_to_last_name
    )

    # buyer information
    shipping_address = {
      :first_name => ship_to_first_name,
      :last_name  => ship_to_last_name,
      :address1   => ship_to_address,
      :city       => ship_to_city,
      :zip        => ship_to_postal_code,
      :country    => ship_to_country_code,
      :phone      => phone_number,
    }

    # order information
    details = {
      :description      => 'INEs Music',
      :order_id         => self.id,
      :email            => email,
      :ip               => customer_ip,
      :billing_address  => shipping_address,
      :shipping_address => shipping_address
    }

    if creditcard.valid? # validating the card automatically detects the card type
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new( # use the test account
        :login    => 'RubyRails1',
        :password => 'RubyRails1'
        # the statement ":test = 'true'" tells the gateway to not to process transactions
      )

      # Active Merchant accepts all amounts as integer values in cents
      response = gateway.purchase(self.total * 100, creditcard, details)

      if response.success?
        self.status = 'processed'
      else
        self.error_message = response.message
      end
    else
      self.error_message = 'Tarjeta de credito no valida'
    end
  end

  def processed?
    self.status == 'processed'
  end

  def failed?
    self.status == 'failed'
  end

  def closed?
    self.status == 'closed'
  end

  def close
    self.status = 'closed'
    save!
  end
end

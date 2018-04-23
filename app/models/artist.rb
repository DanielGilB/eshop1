class Artist < ActiveRecord::Base
  #validates_presence_of :first_name, :last_name
  has_and_belongs_to_many :discs
  validates_presence_of :first_name, :message => 'El nombre no puede estar en blanco'
  validates_length_of :first_name, :in => 2..255, :message => 'El nombre no puede tener menos de dos caracteres'

  def name
    "#{first_name} #{last_name}"
  end
end

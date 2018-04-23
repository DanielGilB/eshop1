class Artist < ActiveRecord::Base
  #validates_presence_of :first_name, :last_name
  has_and_belongs_to_many :discs
  validates_presence_of :first_name
  validates_length_of :first_name, :in => 2..255

  def name
    "#{first_name} #{last_name}"
  end
end

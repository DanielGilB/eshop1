class Producer < ActiveRecord::Base
	has_many :discs
	validates_presence_of :name
	validates_uniqueness_of :name
	validates_length_of :name, :in => 2..255
end

class Producer < ActiveRecord::Base
<<<<<<< HEAD
	has_many:books
	validates_presence_of :name
	validates_uniqueness_of :name
	validates_length_of :name, :in => 2..255
=======
>>>>>>> e4b2e7472974b3f2102b4de60565838ea973e223
end

class Producer < ActiveRecord::Base
	has_many :discs
	validates_presence_of :name, :message => 'El nombre no puede estar en blanco'
	validates_uniqueness_of :name, :message => 'Este nombre ya existe'
	validates_length_of :name, :in => 2..255, :message => 'El nombre no puede tener menos de 2 caracteres.'
end

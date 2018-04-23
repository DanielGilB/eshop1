class Disc < ActiveRecord::Base
  has_and_belongs_to_many :artists
  belongs_to :producer

  #has_many :cart_items
  #has_many :carts, :through => :cart_items

  has_attached_file :cover_image
  validates_attachment :cover_image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :title, :in => 1..255, :message => 'El título no puede estar en blanco'
  validates_presence_of :producer, :message => 'Se necesita al menos una productora'
  validates_presence_of :artists, :message => 'Se necesita al menos un autor'
  validates_presence_of :produced_at, :message => 'Se necesita una fecha de producción'
  validates_numericality_of :price, :message => 'Se necesita un precio en formato numérico'
  validates_length_of :serial_number, :in => 1..5 , :message => 'El número de serie tiene que estar comprendido entre 1 y 5 caracteres'
  validates_uniqueness_of :serial_number, :message => 'Este número de serie ya existe'

  def artist_names
    self.artists.map{|artist| artist.name}.join(", ")
  end

  #def self.latest(num)
  #  all.order("discs.id desc").includes(:artists, :producer).limit(num)
  #end
end

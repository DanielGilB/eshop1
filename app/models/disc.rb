class Disc < ActiveRecord::Base
  has_and_belongs_to_many :artists
  belongs_to :producer

  #has_many :cart_items
  #has_many :carts, :through => :cart_items

  #has_attached_file :cover_image
  #validates_attachment :cover_image,
  #:content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :title, :in => 1..255
  validates_presence_of :producer
  validates_presence_of :artists
  validates_presence_of :produced_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_length_of :serial_number, :in => 1..5
  validates_uniqueness_of :serial_number

  def artist_names
    self.artists.map{|artist| artist.name}.join(", ")
  end

  #def self.latest(num)
  #  all.order("books.id desc").includes(:artists, :producer).limit(num)
  #end
end

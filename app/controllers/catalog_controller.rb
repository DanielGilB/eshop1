class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  def show
    @disc = Disc.find(params[:id])
    @page_title = @disc.title
  end

  def index
    @discs = Disc.order("discs.id desc").includes(:artists, :producer).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catálogo'
  end

  def latest
    @discs = Disc.latest 5 # invoques "latest" method to get the five latest discs
    @page_title = 'Últimos discos'
  end

  def search
    @page_title = "Buscar"
    if params[:title] 
      @discs = Disc.find_with_ferret(params[:title])
    unless @discs.size > 0
        flash.now[:notice] = "No se han encontrado discos con la búsqueda establecida."
      end
    end
  end

  def rss
    latest
    render :layout => false
    response.headers["Content-Type"] = "application/xml; version=1.0; charset=utf-8"
  end
end
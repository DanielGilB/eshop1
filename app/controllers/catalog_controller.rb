class CatalogController < ApplicationController
  #before_filter :initialize_cart, :except => :show
  #before_filter :require_no_user

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
    @page_title = 'Latest discs'
  end
end

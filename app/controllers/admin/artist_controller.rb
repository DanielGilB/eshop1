class Admin::ArtistController < ApplicationController
	def new
    @artist = Artist.new
    @page_title = 'Create new artist'
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "Artista #{@artist.name} insertado con éxito."
      redirect_to :action => 'index'
    else
      @page_title = 'Insertar nuevo artista'
      render :action => 'new'
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    @page_title = 'Editar artista'
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(artist_params)
      flash[:notice] = "El artista #{@artist.name} fue actualizado con éxito."
      redirect_to :action => 'show', :id => @artist
    else
      @page_title = 'Editar artista'
      render :action => 'edit'
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artista #{@artist.name} eliminado con éxito."
    redirect_to :action => 'index'
  end

  def show
    @artist = Artist.find(params[:id])
    @page_title = @artist.name
  end

  def index
    @artists = Artist.all
    @page_title = 'Mostrando Artistas'
  end

  private
    def artist_params
      params.require(:artist).permit(:first_name, :last_name)
    end
end

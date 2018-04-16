class Admin::DiscController < ApplicationController
  def new
    load_data
    @disc = Disc.new
    @page_title = 'Create new disc'
  end

  def create
    @disc = Disc.new(disc_params)
    if @disc.save
      flash[:notice] = "Disc #{@disc.title} was succesfully created."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Create new disc'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @disc = Disc.find(params[:id])
    @page_title = 'Edit disc'
  end

  def update
    @disc = Disc.find(params[:id])
    if @disc.update_attributes(disc_params)
      flash[:notice] = "Disc #{@disc.title} was succesfully updated."
      redirect_to :action => 'show', :id => @disc
    else
      load_data
      @page_title = 'Edit disc'
      render :action => 'edit'
    end
  end

  def destroy
    @disc = Disc.find(params[:id])
    @disc.destroy
    flash[:notice] = "Succesfully deleted disc #{@disc.title}."
    redirect_to :action => 'index'
  end

  def show
    @disc = Disc.find(params[:id])
    @page_title = @disc.title
  end

  def index
    sort_by = params[:sort_by]
    @discs = Disc.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Listing discs'
  end

  private

    def load_data
      @artists = Artist.all
      @producers = Producer.all
    end

    def disc_params
      params.require(:disc).permit(:title, :producer_id, :produced_at, { :artist_ids => [] },
                                   :serial_number, :blurb, :price) # añadir :cover_image
    end
end

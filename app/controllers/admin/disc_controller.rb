class Admin::DiscController < Admin::AuthenticatedController
  def new
    load_data
    @disc = Disc.new
    @page_title = 'Insertar disco.'
  end

  def create
    @disc = Disc.new(disc_params)
    if @disc.save
      flash[:notice] = "Disco #{@disc.title} insertado correctamente."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Insertar disco.'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @disc = Disc.find(params[:id])
    @page_title = 'Editar disco.'
  end

  def update
    @disc = Disc.find(params[:id])
    if @disc.update_attributes(disc_params)
      flash[:notice] = "Disco #{@disc.title} actualizado correctamente."
      redirect_to :action => 'show', :id => @disc
    else
      load_data
      @page_title = 'Editar disco.'
      render :action => 'edit'
    end
  end

  def destroy
    @disc = Disc.find(params[:id])
    @disc.destroy
    flash[:notice] = "Disco #{@disc.title} eliminado correctamente."
    redirect_to :action => 'index'
  end

  def show
    @disc = Disc.find(params[:id])
    @page_title = @disc.title
  end

  def index
    sort_by = params[:sort_by]
    @discs = Disc.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Mostrando Discos'
  end

  private

    def load_data
      @artists = Artist.all
      @producers = Producer.all
    end

    def disc_params
      params.require(:disc).permit(:title, :producer_id, :produced_at, { :artist_ids => [] },
                                   :serial_number, :blurb, :price, :cover_image)
    end
end

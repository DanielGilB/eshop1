class Admin::ProducerController < Admin::AuthenticatedController
  def new
    @producer = Producer.new
    @page_title = 'Insertar nueva Productora'
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:notice] = "La Productora #{@producer.name} fue insertada con éxito."
      redirect_to :action => 'index'
    else
      @page_title = 'Create new producer'
      render :action => 'new'
    end
  end

  def edit
    @producer = Producer.find(params[:id])
    @page_title = 'Editar Productora'
  end

  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(producer_params)
       flash[:notice] = "La Productora #{@producer.name} fue actualizada con éxito."
       redirect_to :action => 'show', :id => @producer
    else
       @page_title = 'Editar Productora'
       render :action => 'edit'
    end
  end

  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "La Productora #{@producer.name} fue eliminada con éxito."
    redirect_to :action => 'index'
  end

  def show
    @producer = Producer.find(params[:id])
    @page_title = @producer.name
  end

  def index
    @producers = Producer.all
    @page_title = 'Mostrando Productoras'
  end

  private
    def producer_params
      params.require(:producer).permit(:name)
    end
end
class Admin::OrderController < ApplicationController
  def close
    order = Order.find(params[:id])
    order.close
    flash[:notice] = "La orden ##{order.id} ha sido cerrada."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando orden ##{@order.id}"
  end

  def index
    @status = params[:id]
    if @status.blank?
      @status = 'all'
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end
    @orders = Order.where(conditions).paginate(:page => params[:page], :per_page => 10)
    #traducir estados mediante un switch case
    #@page_title = "Listando #{@status}"
    case @status
    when 'all'
      @page_title = "Listando todas"
    when 'closed'
      @page_title = "Listando cerradas"
    when 'open'
      @page_title = "Listando abiertas"
    when 'processed'
      @page_title = "Listando procesadas"
    when 'failed'
      @page_title = "Listando fallidas"
    end
  end
end

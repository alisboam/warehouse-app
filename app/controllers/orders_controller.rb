class OrdersController < ApplicationController
	
	def index
	end
	
	def new
		@suppliers = Supplier.all
		@warehouses = Warehouse.all
		@order = Order.new
	end

	def create
    p current_user
    order_params = params.require(:order).permit(:supplier_id, :warehouse_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save
    if @order.valid?
      redirect_to @order, notice:'Pedido criado com sucesso'
    else
      @suppliers = Supplier.all
      @warehouses = Warehouse.all
      flash.now[:notice] = 'Não foi possível criar o pedido'
      render 'new'
    end  
  end

  def show
    @order = Order.find(params[:id])
  end
end
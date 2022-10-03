class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    @order = Order.new
  end

  def create
    order_params = params.require(:order).permit(:supplier_id, :warehouse_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save
    if @order.valid?
      redirect_to @order, notice: 'Pedido criado com sucesso'
    else
      @suppliers = Supplier.all
      @warehouses = Warehouse.all
      flash.now[:notice] = 'Não foi possível criar o pedido'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: 'Você não possui acesso a este pedido'
    end
  end

  def search
    @code = params["search"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: 'Você não possui acesso a este pedido'
    end
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def update
    @order = Order.find(params[:id])
    order_params = params.require(:order).permit(:supplier_id, :warehouse_id, :estimated_delivery_date)
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end
end

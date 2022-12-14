class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update, :delivered, :canceled]

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
   
  end

  def search
    @code = params["search"]
    p @code
    if @code.empty?
      flash[:notice] = 'nada'
    else
    @orders = Order.where("code LIKE ?", "%#{@code}%")
    end
  end

  def edit
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def update
    order_params = params.require(:order).permit(:supplier_id, :warehouse_id, :estimated_delivery_date)
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private
  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, notice: 'Você não possui acesso a este pedido'
    end
  end
end

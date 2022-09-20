class WarehousesController < ApplicationController
  def show
		id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new()
  end

  def create
    
    warehouse_params = params.require(:warehouse)
                      .permit(:name, :code, :description, :city, :address, :cep, :area)
    @warehouse = Warehouse.create(warehouse_params)

    if @warehouse.valid?
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
    
  end
end
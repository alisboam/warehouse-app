class ProductModelsController < ApplicationController

  def index
    @product_models = ProductModel.all
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight, :width, :height,
                                                                :depth, :sku, :supplier_id)
    @product_model = ProductModel.create(product_model_params)  
    redirect_to @product_model, notice:'Modelo de produto cadastrado com sucesso'
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all.order(:name)
    puts @suppliers
  end
  
  def show
    @product_model = ProductModel.find(params[:id])
  end

end
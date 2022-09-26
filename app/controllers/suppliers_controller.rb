class SuppliersController < ApplicationController

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new()
  end

  def create
    supplier_params = params.require(:supplier)
                      .permit(:name, :company_name, :cnpj, :address, :email, :telephone)
                      puts supplier_params
    @supplier = Supplier.create(supplier_params)

    if @supplier.valid?
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render 'new'
    end
  end
    
  def index
    @supplier = Supplier.all
  end
  

end
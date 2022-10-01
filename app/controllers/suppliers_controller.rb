class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show edit update]

  def show; end

  def new
    @supplier = Supplier.new
  end

  def create
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

  def edit; end

  def update
    if @supplier.update(supplier_params)
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
      render 'edit'
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    supplier_params = params.require(:supplier)
                            .permit(:name, :company_name, :cnpj, :address, :email, :telephone)
    supplier_params[:cnpj] = supplier_params[:cnpj].gsub(/\D/, '')

    supplier_params
  end
end

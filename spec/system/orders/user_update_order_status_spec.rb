require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    supplier_b = Supplier.create!(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
      cnpj: '95960950000125', address: 'Av Paulista, 28',
      email: 'per@email.com', telephone: '4000095')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, 
                            estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as(user)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Entregue'
    expect(page).not_to have_content 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(estoque).to eq 5
  end

  it 'e pedido foi cancelado' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    supplier_b = Supplier.create!(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
      cnpj: '95960950000125', address: 'Av Paulista, 28',
      email: 'per@email.com', telephone: '4000095')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, 
                            estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as(user)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    click_on order.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Cancelado'
    expect(StockProduct.count).to eq 0
  end
end
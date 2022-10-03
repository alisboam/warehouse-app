require 'rails_helper'

describe 'Usuário procura um pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    login_as(user)
    visit(root_path)
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
      address: 'Av. São Paulo', cep: '20021340',
      description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit(root_path)
    within('header nav') do
      fill_in'Buscar Pedido', with: order.code
      click_on'Buscar'
    end
    expect(page).to have_content("Resultados da busca por: #{order.code}")
    expect(page).to have_content("1 pedido encontrado")
    expect(page).to have_content("#{order.code}")
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
      address: 'Av. São Paulo', cep: '20021340',
      description: 'Galpão destinado a cargas grandes')
    warehouse_b = Warehouse.create!(name: 'Rio de Janeiro', code: 'SDU', city: 'Rio de Janeiro', area: 100_000,
      address: 'Av. Rio de Janeiro', cep: '20021340',
      description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU12345SP')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU54321SP')
    order_a = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU50003RJ')
    order_b = Order.create!(user: user, supplier: supplier, warehouse: warehouse_b, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit(root_path)
    within('header nav') do
      fill_in'Buscar Pedido', with: 'GRU'
      click_on'Buscar'
    end
    expect(page).to have_content("2 pedidos encontrados")
    expect(page).to have_content('GRU12345SP')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('GRU54321SP')
    expect(page).not_to have_content('SDU50003RJ')
    expect(page).not_to have_content('Rio de Janeiro')
  end
end
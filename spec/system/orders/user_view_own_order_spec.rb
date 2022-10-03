require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    visit(root_path)
    within('header nav') do
      click_on 'Pedidos'
    end
    expect(page).to have_content('Pedido')
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    user_john = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    user_jane = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order_1= Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    order_2= Order.create!(user: user_jane, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    order_3= Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    order_4= Order.create!(user: user_jane, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

    login_as(user_john)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    expect(page).to have_content order_1.code
    expect(page).to have_content order_3.code
    expect(page).not_to have_content order_2.code
    expect(page).not_to have_content order_4.code
  end
  it 'e visita um pedido' do
    user_john = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order_1 = Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now.to_fs)
    order_3 = Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
      date = order_1.estimated_delivery_date
      # I18n.localize(1.day.from_now.to_date)
    p date
    login_as(user_john)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    click_on order_1.code
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content order_1.code
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content date
  end

  it 'e não visita pedidos de outros usuários' do
    user_john = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    user_jane = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order= Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, 
                          estimated_delivery_date: 1.day.from_now)
  
    login_as(user_jane)
    visit order_path(order.id)
  
    expect(current_path).not_to eq order_path(order.id) 
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end
end






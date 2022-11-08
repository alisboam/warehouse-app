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
    
    order_1= Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, 
      estimated_delivery_date: 1.day.from_now, status:'pending')
    order_2= Order.create!(user: user_jane, supplier: supplier, warehouse: warehouse, 
      estimated_delivery_date: 1.day.from_now, status:'canceled')
    order_3= Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, 
      estimated_delivery_date: 1.day.from_now, status:'delivered')

    login_as(user_john)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    expect(page).to have_content order_1.code
    expect(page).to have_content 'Pendente'
    expect(page).to have_content order_3.code
    expect(page).to have_content 'Entregue'
    expect(page).not_to have_content order_2.code
    expect(page).not_to have_content 'Cancelado'
  end
  
  it 'e visita um pedido' do
    user_john = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order_1 = Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, 
              estimated_delivery_date: 1.day.from_now.to_fs)
    order_3 = Order.create!(user: user_john, supplier: supplier, warehouse: warehouse, 
              estimated_delivery_date: 1.day.from_now)
    date = order_1.estimated_delivery_date.strftime('%d/%m/%Y')
    
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

  it 'e vê itens do pedido' do
    #Arrange
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
      email: 'magalu@email.com', telephone: '08007733838')
    product_a = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT0900XX', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 3000 , width: 80, height:45, depth: 20, sku: 'SOUND-SAMSU-XPT090XX', supplier: supplier)
    product_c = ProductModel.create!(name: 'Produto C', weight: 1000 , width: 30, height:15, depth: 20, sku: 'SOUND-SAMSU-TPT090XX', supplier: supplier)
    
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000000', description:'Galpão destinado para cargas internacionais')
    
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    #Act
    login_as user
    visit root_path
    within('header nav') do
      click_on'Pedidos'
    end
    click_on order.code
    #Assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'
    expect(page).not_to have_content 'Produto C'
  end
    
end






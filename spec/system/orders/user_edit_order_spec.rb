require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, 
                            estimated_delivery_date: 1.day.from_now)
                            
    visit edit_order_path(order.id)
    expect(current_path).to eq new_user_session_path
  end
                          
  it 'com sucesso' do
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
                            estimated_delivery_date: 1.day.from_now)
    login_as(user)
    visit(root_path)
    within('header nav') do
      click_on'Pedidos'
    end
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select 'Pernambucanas', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Pernambucanas'
    expect(page).to have_content '12/12/2022'
  end

  it 'caso seja o responsável' do
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    jane = User.create!(name: 'Jane', email: 'jane@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order = Order.create!(user: jane, supplier: supplier, warehouse: warehouse, 
                            estimated_delivery_date: 1.day.from_now)
      
    login_as(joao)
    visit edit_order_path(order.id)
    expect(current_path).to eq root_path
  end
end






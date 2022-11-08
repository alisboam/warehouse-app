require 'rails_helper'

describe 'usuário edita status de um pedido' do
  it 'e não é o dono' do
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    jane = User.create!(name: 'Jane', email: 'jane@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
          address: 'Av. São Paulo', cep: '20021340',
          description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
        cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
        email: 'magalu@email.com', telephone: '08007733838')
    
    order = Order.create!(user: jane, supplier: supplier, warehouse: warehouse, 
                            estimated_delivery_date: 1.day.from_now, status: 'pending')
      
    login_as(joao)
    POST(canceled_order_path(order.id)

    expect(response).to redirect_to(root_path)
  end
end
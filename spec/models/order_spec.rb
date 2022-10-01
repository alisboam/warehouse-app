require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
                  address: 'Av. São Paulo', cep: '20021340',
                  description: 'Galpão destinado a cargas grandes')
      supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                  cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
                                  email: 'magalu@email.com', telephone: '08007733838')
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      order = Order.create(user: user, supplier: supplier, warehouse: warehouse, 
                      estimated_delivery_date: '2022-10-01')
            
      expect(order.valid?).to be true
    end
    
  end
    describe 'generate random code' do
    it 'when create an order' do
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
                  address: 'Av. São Paulo', cep: '20021340',
                  description: 'Galpão destinado a cargas grandes')
      supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                  cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
                  email: 'magalu@email.com', telephone: '08007733838')
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      order = Order.create(user: user, supplier: supplier, warehouse: warehouse, 
                          estimated_delivery_date: '2022-10-01')
     
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8
    end
    it 'and code is unique' do
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
                  address: 'Av. São Paulo', cep: '20021340',
                  description: 'Galpão destinado a cargas grandes')
      supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                  cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
                                  email: 'magalu@email.com', telephone: '08007733838')
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      first_order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                                  estimated_delivery_date: '2022-10-01')
      second_order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                                  estimated_delivery_date: '2022-10-01')
     
      expect(second_order.code).not_to eq first_order.code
    end
  end
end

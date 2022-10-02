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
                      estimated_delivery_date: 1.day.from_now)
            
      expect(order.valid?).to be true
    end

    it 'and date is mandatory' do
      order = Order.create(estimated_delivery_date: '')
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'and can not be a past date' do
      order = Order.create(estimated_delivery_date: 1.day.ago)
      order.valid?
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'and can not be today' do
      order = Order.create(estimated_delivery_date: Date.today)
      order.valid?
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'and date must be >= tomorrow ' do
      order = Order.create(estimated_delivery_date: Date.today)
      order.valid?
      expect(order.errors.include?(:estimated_delivery_date)).to be true
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
                          estimated_delivery_date: 1.day.from_now)
     
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 10
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
                                  estimated_delivery_date: 1.day.from_now)
      second_order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                                  estimated_delivery_date: 1.day.from_now)
     
      expect(second_order.code).not_to eq first_order.code
    end
  end
end

require 'rails_helper'

describe 'Usuário visita a pádina de pedidos' do
  it 'e deve estar autenticado' do
    visit(root_path)
    within('nav') do
      click_on 'Pedidos'
    end
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
                                  address: 'Av. São Paulo', cep: '20021340',
                                  description: 'Galpão destinado a cargas grandes')
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: '20/12/2022')

    login_as(user)
    visit(root_path)
    within('nav') do
      click_on 'Pedidos'
    end
    expect(page).to have_content('joao@email.com')
    expect(page).to have_content('Data Prevista de Entrega')
    expect(page).to have_content('20/12/2022')
  end
end

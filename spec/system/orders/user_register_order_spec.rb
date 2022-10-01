require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'com sucesso' do
    Warehouse.create(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
                     address: 'Av. São Paulo', cep: '20021340',
                     description: 'Galpão destinado a cargas grandes')
    warehouse = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                 address: 'Praça Sen. Salgado Filho', cep: '20021340',
                                 description: 'Galpão destinado a cargas pequenas')
    Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                     cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                     email: 'magalu@email.com', telephone: '08007733838')
    supplier = Supplier.create(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
                               cnpj: '95960950000125', address: 'Av Paulista, 28',
                               email: 'per@email.com', telephone: '4000095')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    login_as(user)
    visit(root_path)
    within('nav') do
      click_on 'Pedidos'
    end
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.company_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content('Pedido criado com sucesso')
    expect(page).to have_content('ABC12345')
    expect(page).to have_content('Galpão Destino')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Fornecedor')
    expect(page).to have_content('Pernambucanas S/A')
    expect(page).to have_content('João | joao@email.com')
    expect(page).to have_content('Data Prevista de Entrega')
    expect(page).to have_content('20/12/2022')
  end
end

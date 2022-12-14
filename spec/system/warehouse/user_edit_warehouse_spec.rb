require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de editar' do
    Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Praça Sen. Salgado Filho', cep: '20021340',
                      description: 'Galpão destinado a cargas pequenas')

    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    login_as(user)
    visit(warehouses_path)
    click_on('Aeroporto RJ')
    click_on('Editar')

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Aeroporto RJ')
    expect(page).to have_field('Descrição', with: 'Galpão destinado a cargas pequenas')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Endereço', with: 'Praça Sen. Salgado Filho')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('CEP', with: '20021340')
    expect(page).to have_field('Área', with: '60000')
  end

  it 'com sucesso' do
    Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Praça Sen. Salgado Filho', cep: '20021340',
                      description: 'Galpão destinado a cargas pequenas')

    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    login_as(user)
    visit(warehouses_path)
    click_on('Aeroporto RJ')
    click_on('Editar')
    fill_in 'Nome', with: 'Galeão'
    fill_in 'CEP', with: '18021500'
    click_on 'Enviar'

    expect(page).to have_content 'Galeão'
    expect(page).to have_content '18021500'
    expect(page).to have_content 'Galpão atualizado com sucesso'
  end

  it 'e mantém os campos obrigatórios' do
    Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Praça Sen. Salgado Filho', cep: '20021340',
                      description: 'Galpão destinado a cargas pequenas')

    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    login_as(user)
    visit(warehouses_path)
    click_on('Aeroporto RJ')
    click_on('Editar')
    fill_in 'Nome', with: ''
    fill_in 'CEP', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end

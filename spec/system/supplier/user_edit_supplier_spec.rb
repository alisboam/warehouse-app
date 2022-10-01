require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de editar' do
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit(root_path)
    click_on('Fornecedores')
    click_on('Magalu')
    click_on('Editar')

    expect(page).to have_content 'Editar'
    expect(page).to have_field('Nome Fantasia', with: 'Magalu')
    expect(page).to have_field('Razão Social', with: 'MAGAZINE LUIZA S/A')
    expect(page).to have_field('CNPJ', with: '47960950000121')
    expect(page).to have_field('Endereço', with: 'VOLUNTARIOS DA FRANCA, 28')
    expect(page).to have_field('Email', with: 'magalu@email.com')
    expect(page).to have_field('Telefone', with: '08007733838')
  end

  it 'com sucesso' do
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit(root_path)
    click_on('Fornecedores')
    click_on('Magalu')
    click_on('Editar')

    fill_in 'Nome Fantasia', with: 'Epoca Cosméticos'

    click_on 'Enviar'

    expect(page).to have_content 'Epoca Cosméticos'
  end

  it 'e mantém os campos obrigatórios' do
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit(root_path)
    click_on('Fornecedores')
    click_on('Magalu')
    click_on('Editar')

    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: 'ABC'

    click_on 'Enviar'
  end
end

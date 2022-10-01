require 'rails_helper'

describe 'usuário vê detalhes de um fornecedor' do
  it 'e vê informações adicionais' do
    Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                     cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                     email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit(root_path)
    click_on('Fornecedores')
    click_on('Magalu')

    expect(page).to have_content('Magalu')
    expect(page).to have_content('MAGAZINE LUIZA S/A')
    expect(page).to have_content('47960950000121')
    expect(page).to have_content('VOLUNTARIOS DA FRANCA, 28')
    expect(page).to have_content('magalu@email.com')
    expect(page).to have_content('08007733838')
  end

  it 'e volta a tela de fornecedores' do
    Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                    cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                    email: 'magalu@email.com', telephone: '08007733838')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit(root_path)
    click_on('Fornecedores')
    click_on('Magalu')
    click_on('Voltar')

    expect(current_path).to eq(suppliers_path)
  end
end

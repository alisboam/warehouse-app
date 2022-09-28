require 'rails_helper'

describe 'Usuário vê lista de produtos' do
  it 'com sucesso' do
    supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
              cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
              email: 'magalu@email.com', telephone: '08007733838')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10,
                sku:'TV-32-SAMSU-XPTO', supplier: supplier)
    ProductModel.create!(name: 'Monitor 18', weight: 3000, width: 50, height: 15, depth:20,
                sku:'MOB-32-SAMSU-XPTO', supplier: supplier)

    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end


    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV-32-SAMSU-XPTO'
    expect(page).to have_content 'Magalu'
    expect(page).to have_content 'Monitor 18'
    expect(page).to have_content 'MOB-32-SAMSU-XPTO'
    expect(page).to have_content 'Magalu'
  end

  it 'e não existem galpões cadastrados' do
    visit root_path
    click_on 'Modelos de Produtos'
    expect(page).to have_content 'Não existem produtos cadastrados'

  end

end
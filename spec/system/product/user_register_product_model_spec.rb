require 'rails_helper'

describe 'Usuário cadastra um produto' do
    it 'a partir da tela inicial' do
       
        
        visit(root_path)
        click_on 'Cadastrar Produto'

        expect(page).to have_field('Nome')
        expect(page).to have_field('Peso')
        expect(page).to have_field('Altura')
        expect(page).to have_field('Largura')
        expect(page).to have_field('Profundidade')
        expect(page).to have_field('SKU')
    end

    it 'com sucesso' do

        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')
    
        visit(root_path)
        click_on 'Cadastrar Produto'
        fill_in 'Nome', with: 'TV 40'
        fill_in 'Peso', with: 10_000
        fill_in 'Altura', with: 60
        fill_in 'Largura', with: 90
        fill_in 'Profundidade', with: 10
        fill_in 'SKU', with: 'TV 40-XPTO'
        select 'Magalu', from: 'Fornecedor'
        
        click_on 'Enviar'

        expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
        expect(page).to have_content 'TV 40'
        expect(page).to have_content 'TV 40-XPTO'
        expect(page).to have_content '60cm'
        expect(page).to have_content '90cm'
        expect(page).to have_content '10cm '
        expect(page).to have_content '10000g '
    end
end
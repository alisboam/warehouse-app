require 'rails_helper'

describe 'Usuário cadastra um produto' do
    it 'a partir da tela inicial' do
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(root_path)
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        click_on 'Cadastrar Produto'

        expect(page).to have_field('Nome')
        expect(page).to have_field('Peso')
        expect(page).to have_field('Altura')
        expect(page).to have_field('Largura')
        expect(page).to have_field('Profundidade')
        expect(page).to have_field('SKU')
        expect(page).to have_select('Fornecedor')
    end

    it 'com sucesso' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')
        supplier_b = Supplier.create!(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
            cnpj:'95960950000125',address: 'Av Paulista, 28',
            email: 'per@email.com', telephone: '4000095')
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
    
        visit(product_models_path)
        click_on 'Cadastrar Produto'
        fill_in 'Nome', with: 'TV 40'
        fill_in 'Peso', with: 10_000
        fill_in 'Altura', with: 60
        fill_in 'Largura', with: 90
        fill_in 'Profundidade', with: 10
        fill_in 'SKU', with: 'TV-32-SAMSU-XPTO-500'
        select 'Magalu', from: 'Fornecedor'
        click_on 'Enviar'

        expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
        expect(page).to have_content 'TV 40'
        expect(page).to have_content 'TV-32-SAMSU-XPTO-500'
        expect(page).to have_content '60cm'
        expect(page).to have_content '90cm'
        expect(page).to have_content '10cm '
        expect(page).to have_content '10000g '
    end

    it 'e deve preencher todos os campos' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                    cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
                                    email: 'magalu@email.com', telephone: '08007733838')
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(product_models_path)
        click_on 'Cadastrar Produto'
        fill_in 'Nome', with: ''
        fill_in 'SKU', with: ''
        select 'Magalu', from: 'Fornecedor'
        click_on 'Enviar'

        expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
        expect(page).to have_content 'Nome não pode ficar em branco' 
        expect(page).to have_content 'SKU não pode ficar em branco'
    end
end
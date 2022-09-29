require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
    it 'a partir da tela inicial' do
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(root_path)
        within('nav') do
            click_on 'Fornecedores'
        end
        click_on 'Cadastrar Fornecedor'

        expect(page).to have_field('Nome Fantasia')
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Email')
        expect(page).to have_field('Telefone')
    end

    it 'com sucesso' do
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(suppliers_path)
        click_on 'Cadastrar Fornecedor'
        fill_in 'Nome Fantasia', with: 'Magalu'
        fill_in 'Razão Social', with: 'Magazine Luiza'
        fill_in 'CNPJ', with: '47960950000121'
        fill_in 'Endereço', with: 'VOLUNTARIOS DA FRANCA, 28'
        fill_in 'Email', with: 'magalu@email.com'
        fill_in 'Telefone', with: '08007733838'
        click_on 'Enviar'

        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Magalu'
    end

    it 'com dados incompletos' do
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(suppliers_path)
        click_on 'Cadastrar Fornecedor'
        fill_in 'Nome Fantasia', with: ''
        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Email', with: ''
        fill_in 'Telefone', with: ''
        click_on 'Enviar'

        expect(page).to have_content 'A validação falhou:' 
        expect(page).to have_content 'Nome Fantasia não pode ficar em branco' 
        expect(page).to have_content 'Razão Social não pode ficar em branco'
        expect(page).to have_content 'Endereço não pode ficar em branco'
        expect(page).to have_content 'CNPJ não pode ficar em branco'
        expect(page).to have_content 'Telefone não pode ficar em branco'
        expect(page).to have_content 'Email não pode ficar em branco'
        expect(page).to have_content 'Email não é válido' 
        expect(page).to have_content 'CNPJ não é um número'
        expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'
    end
end
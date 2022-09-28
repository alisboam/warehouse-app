require 'rails_helper'

describe 'Usuário cadastra um galpão' do
    it 'a partir da tela inicial' do
         #Arrange

        #act
        visit(root_path)
        click_on 'Cadastrar Galpão'

        #assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Descrição')
        expect(page).to have_field('Código')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Área')
    end

    it 'com sucesso' do
        #act
        visit(root_path)
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Descrição', with: 'Galpão da zona portuária do Rio de Janeiro'
        fill_in 'Código', with: 'RIO'
        fill_in 'Endereço', with: 'Avenida Rio de Janeiro, 1000'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'CEP', with: '20900000'
        fill_in 'Área', with: '32000'
        click_on 'Enviar'

        # assert
        expect(current_path).to eq warehouses_path
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'Galpão cadastrado com sucesso'
    end

    it 'com dados incompletos' do
        visit(root_path)
        click_on 'Cadastrar Galpão'

        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Enviar'

        expect(page).to have_content 'Galpão não cadastrado'
        expect(page).to have_content "Nome não pode ficar em branco"     
        expect(page).to have_content "Código não pode ficar em branco"
        expect(page).to have_content "Cidade não pode ficar em branco"
        expect(page).to have_content "Descrição não pode ficar em branco"
        expect(page).to have_content "Endereço não pode ficar em branco"
        expect(page).to have_content "CEP não pode ficar em branco"
        expect(page).to have_content "Área não pode ficar em branco"
        expect(page).to have_content "Código não possui o tamanho esperado (3 caracteres)"
        expect(page).to have_content "CEP não possui o tamanho esperado (8 caracteres)"
        expect(page).to have_content "CEP não é um número"
    end
end
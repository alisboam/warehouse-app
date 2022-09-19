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
        fill_in 'CEP', with: '20900-000'
        fill_in 'Área', with: '32000'
        click_on 'Enviar'

        # assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RIO'
        expect(page).to have_content '32000 m2'
        expect(page).to have_content 'Galpão cadastrado com sucesso'
    end
end
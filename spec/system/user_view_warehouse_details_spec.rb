require 'rails_helper'

describe 'usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
        #Arrange
        Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021-340',
                        description: 'Galpão destinado a cargas pequenas')

        #act
        visit(root_path)
        click_on('Aeroporto RJ')

        #assert
        expect(page).to have_content('Galpão SDU')
        expect(page).to have_content('Nome: Aeroporto RJ')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')
        expect(page).to have_content('Praça Sen. Salgado Filho, CEP: 20021-340')
        expect(page).to have_content('Galpão destinado a cargas pequenas')
        
    end    
    
    it 'e volta a tela inicial' do
        #Arrange - criar um galpão
    
        Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021-340',
                        description: 'Galpão destinado a cargas pequenas')

        #act - visitar a tela inicial
        visit(root_path)
        click_on('Aeroporto RJ')
        click_on('Voltar')

        #assert
        expect(current_path).to eq(root_path)
    end


end
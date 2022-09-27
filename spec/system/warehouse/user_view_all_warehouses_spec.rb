require 'rails_helper'

describe 'usuário visita tela galpões' do
    it 'e vê os galpões cadastrados' do
        #Arrange
        #cadastrar 2 galpoes
        Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
            						address: 'Avenida Maceió', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')
        

        #act
        visit(warehouses_path)

        #assert
        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Aeroporto RJ')
        expect(page).to have_content('Maceio')
        
    end

    it 'e não existem galpões cadastrados' do
        #Arrange

        #act
        visit(warehouses_path)

        #assert
        expect(page).to have_content('Não existem galpões cadastrados')
    end

end
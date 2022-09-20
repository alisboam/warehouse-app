require 'rails_helper'

describe 'usuário visita tela inicial' do
    it 'e vê o nome da app' do
        #Arrange

        #act
        visit(root_path)

        #assert
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê os galpões cadastrados' do
        #Arrange
        #cadastrar 2 galpoes
        Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')
        Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
            						address: 'Avenida Maceió', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')
        

        #act
        visit(root_path)

        #assert
        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')
        
        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m2')
    end

    it 'e não existem galpões cadastrados' do
        #Arrange

        #act
        visit(root_path)

        #assert
        expect(page).to have_content('Não existem galpões cadastrados')
        
    end

end
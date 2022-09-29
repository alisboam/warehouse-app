require 'rails_helper'

describe 'usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
        Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')

        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
        login_as(user)
        visit(warehouses_path)
        click_on('Aeroporto RJ')

        expect(page).to have_content('Galpão SDU')
        expect(page).to have_content('Aeroporto RJ')
        expect(page).to have_content('Rio de Janeiro')
        expect(page).to have_content('60000 m2')
        expect(page).to have_content('Praça Sen. Salgado Filho')
        expect(page).to have_content('20021340')
        expect(page).to have_content('Galpão destinado a cargas pequenas')
        
    end    
    
    it 'e volta a tela inicial' do
        Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Praça Sen. Salgado Filho', cep: '20021340',
                        description: 'Galpão destinado a cargas pequenas')
        user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

        login_as(user)
        visit(warehouses_path)
        click_on('Aeroporto RJ')
        click_on('Voltar')

        expect(current_path).to eq(root_path)
    end
end
require 'rails_helper'

describe 'usuário vê detalhes de um fornecedor' do
    it 'e vê informações adicionais' do
        Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')

        #act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Magalu')

        #assert
        expect(page).to have_content('Magalu')
        expect(page).to have_content('MAGAZINE LUIZA S/A')
        expect(page).to have_content('47960950000121')
        expect(page).to have_content('VOLUNTARIOS DA FRANCA, 28')
        expect(page).to have_content('magalu@email.com')
        expect(page).to have_content('08007733838')
        
    end    
    
    # it 'e volta a tela inicial' do
    #     #Arrange - criar um galpão
    
    #     Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
    #                     address: 'Praça Sen. Salgado Filho', cep: '20021340',
    #                     description: 'Galpão destinado a cargas pequenas')

    #     #act - visitar a tela inicial
    #     visit(root_path)
    #     click_on('Aeroporto RJ')
    #     click_on('Voltar')

    #     #assert
    #     expect(current_path).to eq(root_path)
    # end


end
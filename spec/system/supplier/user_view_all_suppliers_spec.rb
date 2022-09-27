require 'rails_helper'

describe 'usuário visita tela galpões' do
    it 'e vê os galpões cadastrados' do
        Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')

        Supplier.create!(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
                    cnpj:'95960950000121',address: 'Av Paulista, 28',
                    email: 'per@email.com', telephone: '4000095')
        

        #act
        visit(suppliers_path)

        #assert
        expect(page).not_to have_content('Não existem fornecedores cadastrados')
        expect(page).to have_content('Magalu')
        expect(page).to have_content('Pernambucanas')
        
    end

    it 'e não existem galpões cadastrados' do
        #Arrange

        #act
        visit(suppliers_path)

        #assert
        expect(page).to have_content('Não existem fornecedores cadastrados')
    end

end
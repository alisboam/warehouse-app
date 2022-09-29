require 'rails_helper'

describe 'usuário visita tela fornecedores' do
    it 'e vê os fornecedores cadastrados' do
        Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')

        Supplier.create!(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
                    cnpj:'95960950000121',address: 'Av Paulista, 28',
                    email: 'per@email.com', telephone: '4000095')
        
        visit (root_path)
        click_on 'Fornecedores'

        expect(page).not_to have_content('Não existem fornecedores cadastrados')
        expect(page).to have_content('Magalu')
        expect(page).to have_content('Pernambucanas')
        
    end

    it 'e não existem fornecedores cadastrados' do
        visit(suppliers_path)
        expect(page).to have_content('Não existem fornecedores cadastrados')
    end
end
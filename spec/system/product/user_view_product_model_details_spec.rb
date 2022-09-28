require 'rails_helper'

describe 'usuário vê detalhes de um produto' do
    it 'e vê informações adicionais' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10,
              sku:'TV-32-SAMSU-XPTO', supplier: supplier)

        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')

        expect(page).to have_content 'TV 32'
        expect(page).to have_content 'TV-32-SAMSU-XPTO'
        expect(page).to have_content '70cm'
        expect(page).to have_content '45cm'
        expect(page).to have_content '10cm'
        expect(page).to have_content '8000g'
        expect(page).to have_content 'Magalu'
    end    
    
    it 'e volta a tela de produtos' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
            cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
            email: 'magalu@email.com', telephone: '08007733838')
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10,
              sku:'TV-32-SAMSU-XPTO', supplier: supplier)
        
        visit root_path
        within('nav') do
          click_on 'Modelos de Produtos'
        end
        click_on('TV 32')
        click_on('Voltar')
       
        expect(current_path).to eq(product_models_path)
    end
end
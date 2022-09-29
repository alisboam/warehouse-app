require 'rails_helper'

describe 'usuário visita tela inicial' do
    it 'e vê o nome da app' do
        visit(root_path)
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê a barra de navegação' do
        visit(root_path)
        expect(page).to have_content('Galpões')
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('Modelos de Produtos')
        expect(page).to have_content('Página Inicial')
        
    end

    it 'e clica no link página inicial' do
        visit(root_path)
        within('nav') do
        click_on('Página Inicial')
        end
        expect(current_path).to eq(root_path)
    end

    it 'e clica no link galpões' do
        visit(root_path)
        within('nav') do
            click_on('Galpões')
        end
            expect(current_path).to eq(warehouses_path)
    end

    it 'e clica no link fornecedores' do
        visit(root_path)
        within('nav') do
            click_on('Fornecedores')
        end
        expect(current_path).to eq(suppliers_path)
    end

    # it 'e clica no link cadastrar fornecedor' do
    #     visit(root_path)
    #     click_on('Cadastrar Fornecedor')
    #     expect(current_path).to eq(new_supplier_path)
    # end

    it 'e clica no link modelos de produtos' do
        visit(root_path)
        within('nav') do
            click_on('Modelos de Produtos')
        end
        expect(current_path).to eq(product_models_path)
    end
end
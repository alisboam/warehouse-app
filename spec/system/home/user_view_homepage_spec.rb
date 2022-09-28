require 'rails_helper'

describe 'usuário visita tela inicial' do
    it 'e vê o nome da app' do
        visit(root_path)
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê a barra de navegação' do
        visit(root_path)
        expect(page).to have_content('Página Inicial')
        expect(page).to have_content('Cadastrar Galpão')
        expect(page).to have_content('Galpões')
        expect(page).to have_content('Cadastrar Fornecedor')
        expect(page).to have_content('Fornecedores')
        
    end

    it 'e clica no link página inicial' do
        visit(root_path)
        within('nav') do
        click_on('Página Inicial')
        expect(current_path).to eq(root_path)
        end
    end

    it 'e clica no link galpões' do
        visit(root_path)
        click_on('Galpões')
        expect(current_path).to eq(warehouses_path)
    end

    it 'e clica no link cadastrar galpões' do
        visit(root_path)
        click_on('Cadastrar Galpão')
        expect(current_path).to eq(new_warehouse_path)
    end

    it 'e clica no link fornecedores' do
        visit(root_path)
        click_on('Fornecedores')
        expect(current_path).to eq(suppliers_path)
    end

    it 'e clica no link cadastrar fornecedor' do
        visit(root_path)
        click_on('Cadastrar Fornecedor')
        expect(current_path).to eq(new_supplier_path)
    end

    it 'e clica no link modelos de produtos' do
        visit(root_path)
        within('nav') do
        click_on('Modelos de Produtos')
        expect(current_path).to eq(product_models_path)
        end
    end
end
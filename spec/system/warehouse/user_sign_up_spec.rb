require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    within('nav') do
      expect(page).to have_content 'joao@email.com'
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
    end
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
  end
end
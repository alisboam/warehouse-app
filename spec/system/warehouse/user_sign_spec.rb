# require 'rails_helper'

# describe 'Usuário se autentica' do
#   it 'com sucesso' do
#     User.create(email: 'joao@email.com', password: 'password')

#     visit root_path
#     click_on 'Entrar'
#     fill_in 'Email', with: 'joao@email.com'
#     fill_in 'Senha', with: 'password'
#     click_on 'Entrar'

#     expect(page).to have_link 'Sair'
#     expect(page).not_to have_link 'Entrar'
#     within('nav') do
#       expect(page).to have_content 'joao@email.com'
#     end
#   end
# end
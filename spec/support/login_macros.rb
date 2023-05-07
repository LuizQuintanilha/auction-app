def login(admin)
  within('nav') do
    click_on 'Entrar'
  end
  within('form') do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Entrar'
  end
end
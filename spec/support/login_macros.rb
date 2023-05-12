def login(admin)
  within('nav.admin') do
    click_on 'Admin'
  end
  within('form') do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Entrar'
  end
end


def login(user)
  within('nav.user') do
    click_on 'Usuário'
  end
  within('form') do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end

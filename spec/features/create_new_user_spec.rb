require 'rails_helper'

feature 'User visits new user page' do
  scenario 'successfully' do
    visit new_user_url

    expect(page).to have_css('h2', text: 'Sign up, using:')
    expect(page).to have_selector("input[name='user[name]'][type='text']")
    expect(page).to have_selector("label[for='user_name']")
    expect(page).to have_selector("input[name='user[email]'][type='text']")
    expect(page).to have_selector("label[for='user_username']")
    expect(page).to have_selector("input[name='user[username]'][type='text']")
    expect(page).to have_selector("label[for='user_email']")
    expect(page).to have_selector("input[name='user[password]'][type='password']")
    expect(page).to have_selector("label[for='user_password']")
    # expect(page).to have_selector("input[name='user[password_confirmation]'][text='password']")
    # expect(page).to have_selector("label[for='user_password_confirmation']")

    expect(page).to have_button 'Sign Up'
  end
end

feature 'User creates new user' do
  before :each do
    visit new_user_url
    fill_in 'user[name]', with: 'Charles Xavier'
    fill_in 'user[username]', with: 'profx'
    fill_in 'user[email]', with: 'charlesxavier@example.com'
  end

  scenario 'successfully' do
    fill_in 'user[password]', with: 'charlesxavier'
    click_button 'Sign Up'

    expect(page).to have_content('Charles Xavier')
  end

  scenario 'unsuccessfully' do
    click_button 'Sign Up'

    expect(page).to have_css('h2', text: 'Sign up, using:') 
  end
end
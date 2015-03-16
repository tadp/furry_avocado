require 'rails_helper'

feature 'User visits new user page' do
  scenario 'successfully' do
    visit new_user_url

    expect(page).to have_css('h1', text: 'Sign up, using:')
    expect(page).to have_selector("input[name='user[name]'][type='text']")
    expect(page).to have_selector("label[for='user_name']")
    expect(page).to have_selector("input[name='user[email]'][type='text']")
    expect(page).to have_selector("label[for='user_email']")
    expect(page).to have_selector("input[name='user[password]'][type='password']")
    expect(page).to have_selector("label[for='user_password']")
    # expect(page).to have_selector("input[name='user[password_confirmation]'][text='password']")
    # expect(page).to have_selector("label[for='user_password_confirmation']")

    expect(page).to have_button 'Sign Up'
  end
end
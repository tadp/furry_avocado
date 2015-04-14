require 'rails_helper'

feature 'User visits new session page' do
  scenario 'successfully' do
    visit new_session_url

    expect(page).to have_css('h2', text: 'Sign in, using:')
    expect(page).to have_selector("label[for='session_email']")
    expect(page).to have_selector("input[name='session[email]'][type='text']")
    expect(page).to have_selector("label[for='session_password']")
    expect(page).to have_selector("input[name='session[password]'][type='password']")
    expect(page).to have_button 'Sign In'
  end
end

feature 'User signs in' do
  before :each do
    @user = create(:valid_user)
    visit new_session_url
    fill_in 'session[email]', with: @user.email
  end

  scenario 'successfully' do
    fill_in 'session[password]', with: @user.instance_eval { password }
    click_button 'Sign In'

    expect(page).to have_content(@user.name)
    expect(page).to have_link 'Sign Out'
  end

  scenario 'unsuccessfully' do
    click_button 'Sign In'

    expect(page).not_to have_content(@user.name)
    expect(page).to have_css('h2', text: 'Sign in, using:')
  end
end

feature 'User signs out' do
  scenario 'successfully' do
    @user = create(:valid_user)
    visit new_session_url
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.instance_eval { password }
    click_button 'Sign In'
    click_link 'Sign Out'

    expect(page).not_to have_content(@user.name)
    expect(page).to have_css('h2', text: 'Sign in, using:')
  end
end
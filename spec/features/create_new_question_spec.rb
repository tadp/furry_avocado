require 'rails_helper'

feature 'User visits new question page' do
  scenario 'successfully' do
    @user = create(:valid_user)
    visit new_session_url
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.instance_eval { password }
    click_button 'Sign In'
    visit new_question_url

    expect(page).to have_selector("input[name='question[title]'][type='text']")
    expect(page).to have_selector("label[for='question_title']")
    expect(page).to have_selector("textarea[name='question[body]']")
    expect(page).to have_selector("label[for='question_body']")
    expect(page).to have_button('Post Your Question')
  end

  scenario 'unsuccessfully' do
    visit new_question_url

    expect(page).to have_css('h2', text: 'Sign in, using:')
  end
end

feature 'User creates new question' do
  before :each do
    @user = create(:valid_user)
    visit new_session_url
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.instance_eval { password }
    click_button 'Sign In'
    visit new_question_url
    fill_in 'question[title]', with: 'What is love?'
  end

  scenario 'successfully' do
    fill_in 'question[body]', with: "Baby, don't hurt me"
    click_button 'Post Your Question'

    expect(page).to have_css('h2', text: 'What is love?')
    expect(page).to have_css('p', text: "Baby, don't hurt me")
  end


  scenario 'unsuccessfully' do
    click_button 'Post Your Question'

    expect(page).to have_selector("input[name='question[title]'][type='text']")
    expect(page).to have_selector("label[for='question_title']")
    expect(page).to have_selector("textarea[name='question[body]']")
    expect(page).to have_selector("label[for='question_body']")
    expect(page).to have_button('Post Your Question')
  end
end
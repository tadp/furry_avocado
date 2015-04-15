require 'rails_helper'

feature 'User upvotes own question' do
  scenario 'unsuccessfully' do
    @user = create(:another_valid_user)
    @question = create(:question)
    visit new_session_url
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.instance_eval { password }
    click_button 'Sign In'
    visit question_url(@question)
    
    within('.question-vote') do
      click_link ''
    end


  end
end
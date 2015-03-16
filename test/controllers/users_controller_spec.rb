require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #new' do
    before :each do
      get :new
    end

    it 'assigns a new User to @user' do
      expect(assigns :user).to be_a User
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end
end
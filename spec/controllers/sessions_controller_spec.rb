require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'when given valid user credentials' do
      before :each do
        @user = create(:valid_user)
        @old_session_token = @user.session_token
        allow(User).to receive(:find_by_credentials).with(@user.email, @user.instance_eval { password }).and_return(@user)
        post :create, session: valid_user_credentials
      end

      it 'finds the valid user and assigns it to @user' do
        expect(assigns :user).to eq(@user)
      end

      it 'resets the session token of the User' do
        if @user.session_token == @old_session_token
          expect(@user.session_token).not_to be(@old_session_token)
        else
          expect(@user.session_token).not_to eq(@old_session_token)
        end
      end

      it 'sets the session to the user session token' do
        expect(session[:session_token]).to eq(@user.session_token)
      end

      it 'redirects to the appropriate User page' do
        expect(response).to redirect_to(@user)
      end
    end

    context 'when given invalid user credentials' do
      before :each do
        @user = create(:valid_user)
        @old_session_token = @user.session_token
        allow(User).to receive(:find_by_credentials).with(@user.email, 'password').and_return(nil)
        post :create, session: { email: @user.email, password: 'password' }
      end

      it 'does not find a user and assigns nil to @user' do
        expect(assigns :user).to be nil
      end

      it 'does not reset the session token of the User' do
        expect(@user.session_token).to eq(@old_session_token)
      end

      it 'does not set the session to any user session token' do
        expect(session[:session_token]).not_to eq(@user.session_token)
        expect(session[:session_token]).to be nil
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:valid_user)
      @old_session_token = @user.session_token
      session[:session_token] = @user.session_token
      allow(User).to receive(:find_by_session_token).with(session[:session_token]).and_return(@user)
      delete :destroy
    end

    it 'finds the User associated with the current session' do
      expect(assigns :user).to eq(@user)
    end

    it 'resets the session token of the current User' do
      if @user.session_token == @old_session_token
        expect(@user.session_token).not_to be(@old_session_token)
      else
        expect(@user.session_token).not_to eq(@old_session_token)
      end
    end

    it 'sets the current session to nil' do
      expect(session[:session_token]).to be nil
    end
  end

  def valid_user_credentials
    attributes_for(:valid_user_attributes)
  end
end
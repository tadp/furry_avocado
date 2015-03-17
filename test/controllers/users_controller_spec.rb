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

  describe 'GET #show' do
    before :each do
      @user = create(:valid_user)
      get :show, id: User.last
    end

    context 'when given a valid user ID' do
      it 'finds the User and assigns it to @user' do
        expect(assigns :user).to eq(@user)
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    context 'when given a non-existent user ID'
  end

  describe 'POST #create' do
    context 'when given valid user attributes' do
      before :each do
        @user = create(:valid_user)
        allow(User).to receive(:new).with(valid_user_attributes).and_return(@user)
        allow(@user).to receive(:save).and_return(true)
        post :create, user: valid_user_attributes
      end

      it 'assigns a new User to @user' do
        expect(assigns :user).to eq(@user)
      end

      it 'creates a new User' do
        expect(assigns :user).to be_a User
        expect(User.last).to eq(assigns :user)
      end

      it 'redirects to the user' do
        expect(response).to redirect_to(@user)
      end
    end

    context 'when given invalid user attributes' do
      before :each do
        @user = build(:invalid_user_attributes)
        allow(User).to receive(:new).with(invalid_user_attributes).and_return(@user)
        allow(@user).to receive(:save).and_return(false)
        post :create, user: invalid_user_attributes
      end

      it 'assigns a new User to @user' do
        expect(assigns :user).to eq(@user)
      end

      it 'fails to create a new User' do
        expect(assigns :user).to be_a User
        expect(User.last).not_to eq(assigns :user)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  def valid_user_attributes
    attributes_for(:valid_user_attributes)
  end

  def invalid_user_attributes
    attributes_for(:invalid_user_attributes)
  end
end
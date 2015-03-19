require 'rails_helper'

describe User, type: :model do
  describe '#password=' do
    context 'when given an input password' do
      let(:user) { User.new }

      before :each do
        allow(BCrypt::Password).to receive(:create).with('password').and_return('password_digest')
        user.password=('password')
      end

      it 'assigns the input password to a private @password' do
        expect(user.instance_eval { password }).to eq('password')
      end

      it 'assigns a password_digest' do
        expect(user.password_digest).to eq('password_digest')
      end
    end
  end

  describe '::generate_session_token' do
    it 'generates and returns a random base64 string' do
      allow(SecureRandom).to receive(:urlsafe_base64).with(16).and_return('session_token')
      session_token = User.generate_session_token

      expect(SecureRandom).to have_received(:urlsafe_base64).with(16)
      expect(session_token).to eq('session_token')
    end
  end

  describe '#ensure_session_token' do
    let(:user) { User.new }

    it 'returns a session_token' do
      allow(User).to receive(:generate_session_token).and_return('session_token')
      session_token = user.instance_eval { ensure_session_token }

      expect(session_token).to eq('session_token')
    end

    context 'when not assigned a session token' do
      it 'generates a new session token and assigns it to the user' do
        allow(User).to receive(:generate_session_token).and_return('session_token')
        session_token = user.instance_eval { ensure_session_token }

        expect(User).to have_received(:generate_session_token)
        expect(user.session_token).to eq(session_token)
      end
    end

    context 'when already assigned a session token' do
      it 'returns the already assigned session token' do
        user.session_token = 'already_assigned_session_token'
        allow(User).to receive(:generate_session_token).and_return('session_token')
        session_token = user.instance_eval { ensure_session_token }

        expect(User).not_to have_received(:generate_session_token)
        expect(user.session_token).to eq('already_assigned_session_token')
      end
    end
  end

  describe '::find_by_credentials' do
    before :each do
      @user = create(:valid_user)
    end

    context 'when given valid user credentials' do
      it 'returns the associated User' do
        found_user = User.find_by_credentials('charlessleasman@example.com', 'charlessleasman')
        expect(found_user).to eq(@user)
      end
    end

    context 'when given invalid email' do
      it 'returns nil' do
        invalid_user = User.find_by_credentials('invalid_user@example.com', 'password')
        expect(invalid_user).to be nil
      end
    end

    context 'when given a valid email and an invalid password' do
      it 'returns nil' do
        invalid_user = User.find_by_credentials('charlessleasman@example.com', 'password')
        expect(invalid_user).to be nil
      end
    end
  end

  describe '#is_password?' do
    before :each do
      @user = create(:valid_user)
      @password_instance = double(:password_digest)
      allow(BCrypt::Password).to receive(:new).with(@user.password_digest).and_return(@password_instance)
    end

    context 'when given the correct password' do
      it 'returns true' do
        allow(@password_instance).to receive(:is_password?).with('charlessleasman').and_return(true)
        correct = @user.is_password?('charlessleasman')

        expect(correct).to be true
      end
    end

    context 'when given the incorrect password' do
      it 'returns false' do
        allow(@password_instance).to receive(:is_password?).with('password').and_return(false)
        correct = @user.is_password?('password')

        expect(correct).to be false
      end
    end

    context 'when given a blank password' do
      it 'returns false' do
        allow(@password_instance).to receive(:is_password?).with('').and_return(false)
        correct = @user.is_password?('')

        expect(correct).to be false
      end
    end
  end

  describe '#reset_session_token!' do
    before :each do
      @user = create(:valid_user)
      @old_session_token = @user.session_token
      @new_session_token = @user.reset_session_token!
    end

    it 'assigns the session token to a new random base64 string and saves it' do
      if @user.session_token == @old_session_token
        expect(@user.session_token).not_to be(@old_session_token)
      else
        expect(@user.session_token).not_to eq(@old_session_token)
      end
    end

    it 'returns the session token' do
      expect(@new_session_token).to eq(@user.session_token)
    end
  end
end
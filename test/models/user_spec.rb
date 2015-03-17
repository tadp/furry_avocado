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

    it 'generates a new session_token and assigns it to the user' do
      allow(User).to receive(:generate_session_token).and_return('session_token')
      session_token = user.ensure_session_token
      expect(User).to have_received(:generate_session_token)
      expect(user.session_token).to eq(session_token)
    end
  end
end
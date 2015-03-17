FactoryGirl.define do
  factory :another_valid_user, class: :user do
    name 'Daniel Kim'
    email 'danielkim@example.com'
    password 'danielkim'
    password_digest { BCrypt::Password.create('danielkim') }
    session_token { SecureRandom::urlsafe_base64(16) }
  end

  factory :valid_user, class: :user do
    name 'Charles Sleasman'
    email 'charlessleasman@example.com'
    password 'charlessleasman'
    password_digest { BCrypt::Password.create('charlessleasman') }
    session_token { SecureRandom::urlsafe_base64(16) }
  end

  factory :valid_user_attributes, class: :user do
    name 'Charles Sleasman'
    email 'charlessleasman@example.com'
    password 'charlessleasman'
  end

  factory :invalid_user_attributes, class: :user do
    name nil
    email nil
    password nil
  end
end
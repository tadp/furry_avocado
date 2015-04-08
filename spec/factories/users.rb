FactoryGirl.define do
  factory :another_valid_user, class: :user do
    name 'Bruce Wayne'
    email 'brucewayne@example.com'
    password 'brucewayne'
    password_digest { BCrypt::Password.create('brucewayne') }
    session_token { SecureRandom::urlsafe_base64(16) }
  end

  factory :valid_user, class: :user do
    name 'Charles Xavier'
    email 'charlesxavier@example.com'
    password 'charlesxavier'
    password_digest { BCrypt::Password.create('charlesxavier') }
    session_token { SecureRandom::urlsafe_base64(16) }
  end

  factory :valid_user_attributes, class: :user do
    name 'Charles Xavier'
    email 'charlesxavier@example.com'
    password 'charlesxavier'
  end

  factory :invalid_user_attributes, class: :user do
    name nil
    email nil
    password nil
  end
end
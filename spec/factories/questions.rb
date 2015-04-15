FactoryGirl.define do
  factory :question do
    title 'What is love?'
    body "Baby don't hurt me."
    author { create(:valid_user) }
    
    factory :question_with_tags do
      after(:create) do |question|
        question.tags << create(:tag, question: question)
        question.tags << create(:another_tag, question: question)
      end
    end

    factory :question_with_responses do
      after(:create) do |question|
        question.responses << create(:response, question: question)
      end
    end
  end
end

FactoryGirl.define do
  factory :tag do
    name 'No'
  end

  factory :another_tag, class: :tag do
    name 'more'
  end
end

FactoryGirl.define do
  factory :response do
    body 'Lorem ipsum dolor'
    after(:build) do |response|
      response.author create(:another_valid_user)
    end
  end
end
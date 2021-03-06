require 'rails_helper'

describe Question, type: :model do
  it { should belong_to(:author) }

  it { should have_many(:votes) }
  it { should have_many(:upvoters) }
  it { should have_many(:downvoters) }

  it { should have_many(:tag_assignments) }
  it { should have_many(:tags) }

  it { should have_many(:responses) }

  it { should have_many(:comments) }
  it { should have_many(:commenters) }
end
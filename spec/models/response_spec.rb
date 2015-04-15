require 'rails_helper'

describe Response, type: :model do
  it { should belong_to(:author) }

  it { should belong_to(:question) }

  it { should have_many(:votes) }
  it { should have_many(:upvoters) }
  it { should have_many(:downvoters) }

  it { should have_many(:comments) }
  it { should have_many(:commenters) }
end
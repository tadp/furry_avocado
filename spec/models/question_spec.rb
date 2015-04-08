require 'rails_helper'

describe Question, type: :model do
  it { should belong_to(:author) }
  it { should have_many(:votes) }
  it { should have_many(:voters) }
end
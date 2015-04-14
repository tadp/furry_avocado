require 'rails_helper'

describe Vote, type: :model do
  it { should belong_to(:voter) }
  it { should belong_to(:voteable) }
end
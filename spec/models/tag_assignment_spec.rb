require 'rails_helper'

describe TagAssignment, type: :model do
  it { should belong_to(:tag) }
  it { should belong_to(:taggable) }
end
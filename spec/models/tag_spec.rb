require 'rails_helper'

describe Tag, type: :model do
  it { should have_many(:tag_assignments) }
  it { should have_many(:questions) }
end
require 'rails_helper'

describe Comment, type: :model do
  it { should belong_to(:commenter) }
  it { should belong_to(:commentable) }
end
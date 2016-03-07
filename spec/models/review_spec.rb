require "rails_helper"

describe Review do
  it { should belong_to(:artist) }
  it { should belong_to(:drawing) }
  it { should validate_uniqueness_of(:drawing_id).scoped_to(:artist_id) }
end

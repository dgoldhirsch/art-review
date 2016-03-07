require "rails_helper"

describe Drawing do
  it { should belong_to(:artist) }
  it { should have_many(:reviews) }

  describe ".for_review_by" do
    # Four  artists
    [:p1, :p2, :p3, :p4].each do |p|
      let!(p) { Artist.create! }
    end

    # A drawing by p1
    let!(:d0) { Drawing.create!(artist: p1) }

    # All the rest of the drawings are by p2
    [:d1, :d2, :d3, :d4].each do |d|
      let!(d) { Drawing.create!(artist: p2) }
    end

    before do
      # Drawing 1 (by p2) already reviewed by p1
      Review.create!(drawing: d1, artist: p1)

      # Drawing 3 (by p2) reviewed by p3 and p4
      Review.create!(drawing: d3, artist: p3)
      Review.create!(drawing: d3, artist: p4)

      # Drawing 4 (by p2) reviewed by only p3
      Review.create!(drawing: d4, artist: p3)

      # Note that Drawing 2 (by p2) hasn't been reviewed by anyone
    end

    context "bd's algorithm" do
      subject { Drawing.for_review_by(p1.id, :bd).to_a }

      it "returns drawings in order of least reviewed" do
        should eq([d2, d4, d3])
      end
    end
  end
end

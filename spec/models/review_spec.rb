require 'rails_helper'
require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it 'should be destroyed when restaurant is destroyed' do
    kfc = Restaurant.create name:'KFC'
    kfc.reviews.create(thoughts: 'so so')
    kfc.destroy
    expect(Review.find_by thoughts: 'so so').to equal nil
  end

  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

end

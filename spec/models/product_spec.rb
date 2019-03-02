require 'rails_helper'

describe Product do
  let(:product) { Product.create!(name: "climbing shoe") }
  let(:user) { User.create!(email: "davidlucashopkins@gmail.com", password: "admin1")}


  before do
    product.comments.create!(rating: 1, user: user, body: "Awful shoe!")
    product.comments.create!(rating: 3, user: user, body: "Ok shoe!")
    product.comments.create!(rating: 5, user: user, body: "Great shoe!")
  end

  it "returns the average rating of all comments" do
    expect(product.average_rating).to eq 3
  end
  
  it "is not valid without a comment" do
    expect(Product.new(description: "Nice shoe!")).not_to be_valid
  end
end
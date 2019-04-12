require 'rails_helper'

describe Comment do
  context "when the product has comments" do

    let(:user) { User.create!(email: "test@gmail.com", password: "test111") }

    let(:product) { Product.create!(name: "shoe") }

    before do
      product.comments.create!(rating: 5, user: user, body: "comment")
    end

    it "is not valid without a user" do
      expect(Comment.new(rating: 5, body: "comment")).not_to be_valid
    end

    it "is not valid without a body" do
      expect(Comment.new(body: "")).not_to be_valid
    end

    it "is not valid without a rating" do
      expect(Comment.new(rating: nil)).not_to be_valid
    end

    it "is not valid without a product_id" do
      expect(Comment.new(product_id: nil)).to_not be_valid
    end
  end
end

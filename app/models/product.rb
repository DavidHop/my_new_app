class Product < ApplicationRecord
  has_many :orders
  has_many :comments

    def highest_rating_comment
      comments.rating_desc.first
    end

    def self.search(search_term)
    Product.where("name LIKE ?", "%#{search_term}%")
  end
end

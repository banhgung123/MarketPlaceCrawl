# class Shop
#   include Mongoid::Document
#   field :sellerid, type: Integer
#   field :shopid, type: Integer
#   field :api, type: String
#   field :name, type: String
#   field :categories, type: Object
#   field :ratings, type: Object
#   field :skus, type: Integer
#   field :html, type: String
# end

class Shop
  include Mongoid::Document
  field :seller, type: String
  field :url, type: String
  field :name, type: String
  field :categories, type: Object
  field :rates, type: Object
  field :skus, type: Integer
  field :followers, type: Object
  store_in collection: "shop"
end
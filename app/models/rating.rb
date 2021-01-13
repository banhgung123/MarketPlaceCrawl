class Rating
  include Mongoid::Document
  field :url, type: String
  field :data, type: Object
  store_in collection: "rating"
end

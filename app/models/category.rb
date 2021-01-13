class Category
  include Mongoid::Document
  field :shopid, type: Integer
  field :api, type: String
  field :data, type: Object
  store_in collection: "category"
end

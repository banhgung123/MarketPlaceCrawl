class Info
  include Mongoid::Document
  field :pagedata, type: String
  store_in collection: "info"
end

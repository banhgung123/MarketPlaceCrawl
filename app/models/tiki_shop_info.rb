class TikiShopInfo
  include Mongoid::Document
  field :data, type: Object
  store_in collection: "tiki_shop_info"
end

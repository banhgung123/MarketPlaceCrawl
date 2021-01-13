class ShopeeShopInfo
  include Mongoid::Document
  field :data, type: Object
  store_in collection: "shopee_shop_info"
end

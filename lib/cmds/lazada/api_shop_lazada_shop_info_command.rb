OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# def getShopMore
#     Rating.each do |rat|
#         if !rat["data"].nil? && !rat["data"]["items"].empty? && !rat["data"]["items"][0]["storeUrl"].nil?
#             api = rat["data"]["items"][0]["storeUrl"]
#             cpos = api.index("shop/") + 5
#             shopName = rat["data"]["items"][0]["storeUrl"][cpos, api.length]
#             cchar = shopName.rindex("/").to_i
#             if cchar != 0
#                 shopName = shopName[0, cchar]                
#             end

#             match = Category.find_by("data.storeCategoryLink.link": /#{shopName}/)
#             if !match.nil?
#                 if !match["data"].empty? && !match["data"][0].nil? && !match["data"][0]["storeCategoryLink"].nil? && !match["data"][0]["storeCategoryLink"]["link"].nil?
#                     url = "https://www.lazada.vn/shop/site/api/shop/justForYou/query?shopId=" << match["shopid"].to_s << "&sellerId=" << rat["sellerid"].to_s << "&lang=en&limit=12&offset=0&sourceType=pc"
#                     hash = HTTParty.get(url).parsed_response
#                     shop = Shop.new
#                     shop.sellerid = rat["sellerid"]
#                     shop.shopid = match["shopid"]
#                     shop.api = api
#                     shop.name = shopName
#                     shop.categories = match["data"]
#                     shop.ratings = rat["data"]["ratings"]
#                     if !hash["result"].nil?
#                         shop.skus = hash["result"]["totalCount"]
#                     else
#                        shop.skus = 0 
#                     end
#                     unless shop.save
#                         flash[:errors] = shop.errors.full_messages
#                     end
#                 end
#             end
#         end
#     end
# end

def getShopMore
    Info.each do |info|
        if !info["pagedata"].index("pageData").nil?
            shop = Shop.new
            position = info["pagedata"].index("{")
            pageData = info["pagedata"][position, info["pagedata"].length]
            pageData = JSON.parse(pageData)

            # Followers
            url = "https://www.lazada.vn/shop/renderApi/pcPageData?pageId=#{pageData["pageId"]}&shopId=#{pageData["shopId"]}&clientType=pc&lang=vi&pageType=1"
            hashFollowers = HTTParty.get(url).parsed_response
            if !hashFollowers["result"].nil?
                if !hashFollowers["result"]["globalData"].nil?
                    shop.name = hashFollowers["result"]["globalData"]["sellerKey"]
                end
                if !hashFollowers["result"]["components"].nil?
                    shop.followers = hashFollowers["result"]["components"]
                    # hashFollowers["result"]["components"].each_with_index do |component, index|
                    #     if index == 0
                    #         shop.followers = component
                    #     end
                    #     # component.each_with_index {
                    #     #     |value, key| 
                    #     #     if key == 1
                    #     #         value.each_with_index {
                    #     #             |val, ke|
                    #     #             if ke == 7
                    #     #                 shop.followers = val
                    #     #                 # val.each_with_index {
                    #     #                 #     |v, k| shop.followers = v["followUserNumber"] if k == 1
                    #     #                 # }
                    #     #             end
                    #     #         }
                    #     #     end
                    #     # }
                    #     # break
                    # end
                end
            end

            # Rates
            url = "https://my.lazada.vn/seller/listSellerReviews?sellerId=#{pageData["sellerId"]}&pageNo=1&pageSize=5"
            hashRates = HTTParty.get(url).parsed_response
            if !hashRates["model"].nil?
                if !hashRates["model"]["items"].empty? && !hashRates["model"]["ratings"]["satisfaction"].nil? && hashRates["model"]["ratings"]["satisfaction"][0, 2].to_i >= 70
                    hashRates["model"]["items"].each do |hr|
                        if !hr["storeUrl"].nil?
                            shop.seller = hr["sellerName"]
                            shop.url = hr["storeUrl"]
                            # Get shop name if null
                            if shop.name.nil?
                                cpos = hr["storeUrl"].to_s.index("shop/").to_i + 5
                                shopName = hr["storeUrl"].to_s[cpos, hr["storeUrl"].to_s.length]
                                cchar = shopName.rindex("/").to_i
                                if cchar != 0
                                    shop.name = shopName[0, cchar]
                                else
                                    shop.name = ""            
                                end
                            end
                            break
                        end
                    end
                    shop.rates = hashRates["model"]["ratings"]
                end
            end

            # Categories
            url = "https://www.lazada.vn/shop/site/api/shop/storeCategory/query?shopId=#{pageData["shopId"]}"
            hashCategories = HTTParty.get(url).parsed_response
            if hashCategories["result"].class.to_s == "Array"
                if !hashCategories["result"].empty?
                    shop.categories = hashCategories["result"]
                end
            else
                if !hashCategories["result"].nil?
                    shop.categories = hashCategories["result"]
                end
            end

            # Skus
            url = "https://www.lazada.vn/shop/site/api/shop/justForYou/query?shopId=#{pageData["shopId"]}&sellerId=#{pageData["shopId"]}&lang=en&limit=12&offset=0&sourceType=pc"
            hashSkus = HTTParty.get(url).parsed_response
            if !hashSkus["result"].nil?
                shop.skus = hashSkus["result"]["totalCount"]
            else
                shop.skus = 0 
            end

            unless shop.save
                flash[:errors] = shop.errors.full_messages
            end
            sleep 1.0 
        end
    end
end


getShopMore
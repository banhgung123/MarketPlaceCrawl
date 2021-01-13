OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def getShopeeShopInfo
    if !ARGV[0].nil? && !ARGV[1].nil?
        if  ARGV[0].match(/^[0-9]*$/) && ARGV[1].match(/^[0-9]*$/) && ARGV.length == 2
            for i in ARGV[0].to_i..ARGV[1].to_i
                url = "https://shopee.vn/api/v2/shop/get?shopid=#{i}"
                hash = HTTParty.get(url).parsed_response
                if !hash["data"].nil?
                    if hash["data"]["rating_star"].to_f > 3
                        shopee = ShopeeShopInfo.new
                        shopee.data = hash["data"]
                        unless shopee.save
                            flash[:errors] = shopee.errors.full_messages
                        end
                    end
                end
                sleep 1.0
            end
        else
            puts "Please type a correct integer number!"
        end
    else
        puts "Please type a correct integer number!"
    end
end

getShopeeShopInfo
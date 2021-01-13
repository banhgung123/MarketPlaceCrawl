OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def getTikiShopInfo
    if !ARGV[0].nil? && !ARGV[1].nil?
        if  ARGV[0].match(/^[0-9]*$/) && ARGV[1].match(/^[0-9]*$/) && ARGV.length == 2
            for i in ARGV[0].to_i..ARGV[1].to_i
                url = "https://seller-store-api.tiki.vn/seller-profiles/#{i}"
                hash = HTTParty.get(url).parsed_response
                if !hash.nil? && !hash["status"].nil? && !hash["product_quantity"].nil?
                    if hash["status"] === 1 && hash["product_quantity"] > 0
                        tiki = TikiShopInfo.new
                        tiki.data = hash
                        unless tiki.save
                            flash[:errors] = tiki.errors.full_messages
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

getTikiShopInfo
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# def getCategoryMore
#     if !ARGV[0].nil?
#         if  ARGV[0].match(/^[0-9]*$/) && ARGV.length == 1
#             for i in 1..ARGV[0].to_i
#                 url = "https://www.lazada.vn/shop/site/api/shop/storeCategory/query?shopId=#{i}"
#                 hash = HTTParty.get(url).parsed_response
                
#                 if hash["result"].class.to_s == "Array"
#                     if !hash["result"].empty?
#                         category = Category.new
#                         category.shopid = i
#                         category.api = url
#                         category.data = hash["result"]
#                         unless category.save
#                             flash[:errors] = category.errors.full_messages
#                         end
#                     end
#                 else
#                     if !hash["result"].nil?
#                         category = Category.new
#                         category.shopid = i
#                         category.api = url
#                         category.data = hash["result"]
#                         unless category.save
#                             flash[:errors] = category.errors.full_messages
#                         end
#                     end
#                 end
#                 sleep 1.0 
#             end
#         else
#             puts "Please type a correct integer number!"
#         end
#     else
#         puts "Please type a correct integer number!"
#     end
# end

def getCategoryMore
    Info.each do |info|
        position = info["pagedata"].index("{")
        pageData = info["pagedata"][position, info["pagedata"].length]
        pageData = JSON.parse(pageData)
        url = "https://www.lazada.vn/shop/site/api/shop/storeCategory/query?shopId=#{pageData["shopId"]}"
        hash = HTTParty.get(url).parsed_response
        
        if hash["result"].class.to_s == "Array"
            if !hash["result"].empty?
                category = Category.new
                category.shopid = pageData["shopId"]
                category.api = url
                category.data = hash["result"]
                unless category.save
                    flash[:errors] = category.errors.full_messages
                end
            end
        else
            if !hash["result"].nil?
                category = Category.new
                category.shopid = pageData["shopId"]
                category.api = url
                category.data = hash["result"]
                unless category.save
                    flash[:errors] = category.errors.full_messages
                end
            end
        end
        sleep 1.0
        break
    end
end

getCategoryMore
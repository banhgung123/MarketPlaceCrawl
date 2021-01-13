OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def getRatingMore
    if !ARGV[0].nil? && !ARGV[1].nil?
        if  ARGV[0].match(/^[0-9]*$/) && ARGV[1].match(/^[0-9]*$/) && ARGV.length == 2
            for i in ARGV[0].to_i..ARGV[1].to_i
                url = "https://my.lazada.vn/seller/listSellerReviews?sellerId=#{i}&pageNo=1&pageSize=5"
                hash = HTTParty.get(url).parsed_response
                if !hash["model"].nil?
                    if !hash["model"]["items"].empty? && !hash["model"]["ratings"]["satisfaction"].nil? && hash["model"]["ratings"]["satisfaction"][0, 2].to_i >= 70
                        rating = Rating.new
                        rating.url = hash["model"]["items"][0]["storeUrl"]
                        rating.data = hash["model"]
                        unless rating.save
                            flash[:errors] = rating.errors.full_messages
                        end
                    end
                end
                sleep 1.0
            end
            # exportExcelForRating
        else
            puts "Please type a correct integer number!"
        end
    else
        puts "Please type a correct integer number!"
    end
end

def exportExcelForRating
    if Rating.count > 0
        Spreadsheet.client_encoding = 'UTF-8'
        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet
        sheet1.name = "Ratings_Collection"
        sheet1.row(0).concat %w{Api SellerId SellerName SellerIcon StoreUrl Satisfaction RateCount ReviewCount Scores(Positive) Scores(Neutral) Scores(Negative)}
        format = Spreadsheet::Format.new :weight => :bold, :size => 11
        sheet1.row(0).default_format = format
        index = 1
        Rating.each do |rat|
            if !rat["data"]["items"].empty?
                sheet1.row(index).push rat["api"], rat["sellerid"], rat["data"]["items"][0]["sellerName"], rat["data"]["items"][0]["sellerIcon"], rat["data"]["items"][0]["storeUrl"], rat["data"]["ratings"]["satisfaction"], rat["data"]["ratings"]["rateCount"], rat["data"]["ratings"]["reviewCount"], rat["data"]["ratings"]["scores"][0], rat["data"]["ratings"]["scores"][1], rat["data"]["ratings"]["scores"][2]
                index+=1
            end
        end
        book.write "C:/Users/#{ENV['USERNAME']}/Downloads/Ratings_Collection.xls"
    end
end

getRatingMore

# def followers
#     require 'open-uri'
#     url = 'https://www.lazada.vn/shop/the-gioi-tin-hoc/?langFlag=vi&path=profile.htm&pageTypeId=3'
#     document = Nokogiri::HTML.parse(open(url))
#     Shop.each do |shop|
#         puts shop["name"]
#         # if shop["name"] === "the-gioi-tin-hoc"
#         #     # shop.update(shop["_id"], {html: document})
#         #     puts shop["html"]
#         # end
#     end
# end

# followers

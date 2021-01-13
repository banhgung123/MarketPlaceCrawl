OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def exportExcelForShop
    if Shop.count > 0
        Spreadsheet.client_encoding = 'UTF-8'
        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet
        sheet1.name = "Lazada_Shops_Collection"
        sheet1.row(0).concat %w{Seller Name Url Categories Followers Satisfaction RateCount ReviewCount Skus Scores(Positive) Scores(Neutral) Scores(Negative)}
        format = Spreadsheet::Format.new :weight => :bold, :size => 11
        sheet1.row(0).default_format = format
        index = 1
        Shop.each do |shop|
            categories = ""
            followers = 0
            if !shop["categories"].nil?
                if !shop["categories"].empty?
                    for i in 0...shop["categories"].length 
                        categories << shop["categories"][i]["name"]
                        if i < shop["categories"].length - 1
                            categories << ","
                        end
                    end
                end
            end
            if !shop["followers"].nil?
                shop["followers"].each_with_index do |follower, index|
                    follower.each_with_index do |fol, ind|
                        if ind == 1
                            if fol["moduleData"].length > 15
                                followers = fol["moduleData"]["followUserNumber"]
                            end
                        end
                        # if fol["moduleData"]["followerUserNumber"].has_key?
                        #     puts "#{ind}: #{fol["moduleData"]["followerUserNumber"]}"
                        # end
                        # if ind == 1
                        #     followers = fol["moduleData"]["followerUserNumber"]
                        # #     # if !fol["moduleData"].nil?
                        # #         puts fol["moduleData"]["followerUserNumber"]
                        # #     # end
                        # # end
                        # # if !fol["moduleData"].nil?
                        #     # if !f["followerUserNumber"].nil?
                        #         # puts "vo day"
                                
                        #     # end
                        #     # if !fol["moduleData"]["followerUserNumber"].nil?
                        #     #     followers = fol["moduleData"]["followUserNumber"]
                        #     # end
                        # end
                    end
                end 
            end
            sheet1.row(index).push shop["seller"], shop["name"], shop["url"], categories, followers, shop["rates"]["satisfaction"], shop["rates"]["rateCount"], shop["rates"]["reviewCount"], shop["skus"], shop["rates"]["scores"][0], shop["rates"]["scores"][1], shop["rates"]["scores"][2]
            index+=1
        end
        book.write "C:/Users/#{ENV['USERNAME']}/Downloads/Lazada_Shops_Collection.xls"
    end
end

exportExcelForShop
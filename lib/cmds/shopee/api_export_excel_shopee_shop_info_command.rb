OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def exportExcelShopeeShopInfo
    if ShopeeShopInfo.count > 0
        Spreadsheet.client_encoding = 'UTF-8'
        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet
        sheet1.name = "Shopee_Shop_Collection"
        sheet1.row(0).concat %w{Seller Name Url Followers StarRate ResponseRate CancellationRate Skus Rating(Good) Rating(Normal) Rating(Bad)}
        format = Spreadsheet::Format.new :weight => :bold, :size => 11
        sheet1.row(0).default_format = format
        index = 1
        ShopeeShopInfo.each do |shop|
            seller = shop["data"]["name"].encode('utf-8')
            url = "https://shopee.vn/" << shop["data"]["account"]["username"]
            rating_star = shop["data"]["rating_star"].round(1)
            response_rate = shop["data"]["response_rate"].to_s << "%"
            cancellation_rate = shop["data"]["cancellation_rate"].to_s << "%"
            sheet1.row(index).push seller, shop["data"]["account"]["username"], url, shop["data"]["follower_count"], rating_star, response_rate, cancellation_rate, shop["data"]["item_count"], shop["data"]["rating_good"], shop["data"]["rating_normal"], shop["data"]["rating_bad"]
            index+=1
        end
        book.write "C:/Users/#{ENV['USERNAME']}/Downloads/Shopee_Shop_Collection.xls"
    end
end

exportExcelShopeeShopInfo
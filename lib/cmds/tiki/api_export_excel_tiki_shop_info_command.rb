OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def exportExcelTikiShopInfo
    if ShopeeShopInfo.count > 0
        Spreadsheet.client_encoding = 'UTF-8'
        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet
        sheet1.name = "Tiki_Shop_Collection"
        sheet1.row(0).concat %w{Seller Name Url WebsiteUrl TikiVerify Skus}
        format = Spreadsheet::Format.new :weight => :bold, :size => 11
        sheet1.row(0).default_format = format
        index = 1
        TikiShopInfo.each do |shop|
            url = "https://tiki.vn/cua-hang/" << shop["data"]["url_slug"]
            verify = shop["data"]["is_verified"] === true ? "Chứng nhận bởi Tiki" : ""
            sheet1.row(index).push shop["data"]["name"], shop["data"]["url_slug"], url, shop["data"]["website_url"], verify, shop["data"]["product_quantity"]
            index+=1
        end
        book.write "C:/Users/#{ENV['USERNAME']}/Downloads/Tiki_Shop_Collection.xls"
    end
end

exportExcelTikiShopInfo
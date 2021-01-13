OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def getInfoMore
    require 'open-uri'
    Rating.each do |rat|
        url = ""
        rat["data"]["items"].each do |r|
            if !r["storeUrl"].nil?
                url = "https:" << r["storeUrl"]
                break
            end
        end
        
        begin    
            document = Nokogiri::HTML.parse(open(url))
            if document.to_s.length != 0
                html = document.css("body")
                first = html.to_s.index("pageData").to_i
                pageData = html.to_s[first, html.to_s.length]
                last = pageData.index(";</script>").to_i
                pageData = pageData[0, last]

                info = Info.new
                info.pagedata = pageData
                info.save
            end
        rescue OpenURI::HTTPError => e
            next if document.to_s.length == 0
        end
        sleep 1.0
    end
end

getInfoMore
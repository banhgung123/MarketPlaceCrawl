# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class ApisController < ApplicationController
    attr_accessor :api, :data

    def initialize(api = "", data = "")
        @api = api
        @data = data
    end

    # def index
    #     @api = Api.new
    # end

    # def create
    #     if params[:commitall]
    #         # self.api_StoreMore
    #         self.api_RatingMore
    #     else
    #         # self.api_Store(params[:api][:urlLink])
    #         self.api_Rating(params[:api][:urlLink])
    #     end
    #     # if params[:commitall]
    #     #     for i in 1..100000
    #     #         link = "https://my.lazada.vn/seller/listSellerReviews?sellerId=#{i}&pageNo=1&pageSize=5"
    #     #         api = Api.new
    #     #         api.urlLink = link
    #     #         hash = HTTParty.get(link).parsed_response
    #     #         api.dataJson = hash["model"].to_json
    #     #         unless api.save
    #     #             flash[:errors] = api.errors.full_messages
    #     #             redirect_to apis_path
    #     #         else
    #     #             api.save
    #     #         end
    #     #     end
    #     # else
    #     #     api = Api.new
    #     #     api.urlLink = params[:api][:urlLink]
    #     #     hash = HTTParty.get(params[:api][:urlLink]).parsed_response
    #     #     api.dataJson = hash.to_json

    #     #     if api.save
    #     #         redirect_to :root, notice: "Get information successfully!"
    #     #     else
    #     #         flash[:errors] = api.errors.full_messages
    #     #         redirect_to apis_path
    #     #     end
    #     # end
    # end

    # def api_Store(link)
    #     hash = HTTParty.get(link).parsed_response
    #     if !hash["result"].empty?
    #         api = Api.new
    #         api.urlLink = link
    #         api.dataJson = hash["result"]
    #         if api.save
    #             redirect_to :root, notice: "Get information successfully!"
    #         else
    #             flash[:errors] = api.errors.full_messages
    #             redirect_to apis_path
    #         end
    #     end
    # end

    # def api_StoreMore()
    #     for i in 2637..2639
    #         link = "https://www.lazada.vn/shop/site/api/shop/storeCategory/query?shopId=#{i}"
    #         hash = HTTParty.get(link).parsed_response
    #         if !hash["result"].empty?
    #             api = Api.new
    #             api.urlLink = link
    #             api.dataJson = hash["result"]
    #             unless api.save
    #                 flash[:errors] = api.errors.full_messages
    #                 redirect_to apis_path
    #             end
    #         end
    #     end
    # end

    # def api_Rating(link)
    #     hash = HTTParty.get(link).parsed_response
    #     if !hash["model"].nil?
    #         if !hash["model"]["ratings"]["satisfaction"].nil? && hash["model"]["ratings"]["satisfaction"][0, 2].to_i >= 80
    #             api = Api.new
    #             api.urlLink = link
    #             api.dataJson = hash["model"]
    #             if api.save
    #                 redirect_to :root, notice: "Get information successfully!"
    #             else
    #                 flash[:errors] = api.errors.full_messages
    #                 redirect_to apis_path
    #             end
    #         else
    #             flash[:errors] = ["Wrong data!"]
    #             redirect_to :root
    #         end
    #     end
    # end

    # def api_RatingMore
    #     for i in 1..10
    #         link = "https://my.lazada.vn/seller/listSellerReviews?sellerId=#{i}&pageNo=1&pageSize=5"
    #         hash = HTTParty.get(link).parsed_response
    #         if !hash["model"].nil?
    #             if !hash["model"]["ratings"]["satisfaction"].nil? && hash["model"]["ratings"]["satisfaction"][0, 2].to_i >= 80
    #                 api = Api.new
    #                 api.urlLink = link
    #                 api.dataJson = hash["model"]
    #                 unless api.save
    #                     flash[:errors] = api.errors.full_messages
    #                     redirect_to apis_path
    #                 end
    #             end
    #         end
    #     end
    # end
end
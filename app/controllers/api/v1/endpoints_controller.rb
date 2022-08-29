class Api::V1::EndpointsController < ApplicationController
    # def fetch
    #     render json: {
    #         "success": 1,
    #         "meta":{
    #             "title": "Codex Team",
    #             "description": "Club of web-development, design and marketing.",
    #             "image": {
    #                 "url": "https://codex.so/public/app/img/meta_img.png",
    #             }
    #         }
    #     }
    # end

    # private
    # require 'rest-client'
    # require 'nokogiri'
    require 'opengraph_parser'

    def fetchUrl
        # puts CGI.unescape(request.url.split('url=').second)
        url = CGI.unescape(request.url.split('url=').second)
        og = OpenGraph.new(url)
        # response = RestClient.get(url)
        # parsed_data = Nokogiri::HTML.parse(response).css('meta')
        # title = parsed_data.title
        # imgUrl = parsed_data.css('meta')
        # parsed_data.each do |meta|
        #     meta.property
        # end
        # puts og.title
        # puts og.images
        # puts og.description
        # render json: {
        #     "text": og.title,
        #     "image": og.images,
        #     "descriptopn": og.description,
        # }
        render json: {
            "success": 1,
            "meta":{
                "title": og.title || null,
                "description": og.description || null,
                "image": {
                    "url": og.images[0] || null,
                }
            }
        }
    end
end

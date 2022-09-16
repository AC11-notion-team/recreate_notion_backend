class Api::V1::EndpointsController < ApplicationController
    require 'opengraph_parser'

    def fetchUrl
        url = CGI.unescape(request.url.split('url=').second)
        og = OpenGraph.new(url)
        
        render json: {
            "success": 1,
            "meta": {
                "title": og.title || nil,
                "description": og.description || nil,
                "image": {
                    "url": og.images.first || nil,
                }
            }
        }
    end

    def uploadImageByUrl 
        render json: {
            "success": 1,
            "file":{
                "url": params["url"],
            }
        }
    end

end

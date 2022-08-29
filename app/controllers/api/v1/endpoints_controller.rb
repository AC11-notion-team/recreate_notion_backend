class Api::V1::EndpointsController < ApplicationController
    def fetch
        render json: {
            "success": 1,
            "meta":{
                "title": "Codex Team",
                "description": "Club of web-development, design and marketing.",
                "image": {
                    "url": "https://codex.so/public/app/img/meta_img.png",
                }
            }
        }
    end
end

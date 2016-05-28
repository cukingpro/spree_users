module Spree
  module Api
    class LikesController < Spree::Api::BaseController

      before_action :authenticate_user

      def create
        @status = if Dish::Like.find_or_create_by(comment_params)
          [{ "messages" => "Like was successfully created" }]

        else
          [{ "messages" => "Like was not successfully created" }]
        end
        render "spree/api/logger/log", status: 200

      end

      def destroy
        @like = Dish::Like.find_by(comment_params)

        @status = if @like.destroy
          [{ "messages" => "Like was successfully destroyed" }]

        else
          [{ "messages" => "Like was not successfully destroyed" }]
        end
        render "spree/api/logger/log", status: 200

      end

      def user_favorites
        @products = current_api_user.like_products
        render "spree/api/products/index", status: 200
      end

      private

      def comment_params
        { user_id: current_user_id }.merge(product_id: params[:product_id], box_id: params[:box_id])
      end
    end
  end
end

module Spree
  module Api
    class LikesController < Spree::Api::BaseController

      before_action :authenticate_user

      def create
        if Dish::Like.find_or_create_by(user_id: current_user_id, product_id: params[:product_id])
          @status = [ { "messages" => "Like was successfully created"}]

        else
          @status = [ { "messages" => "Like was not successfully created"}]
        end
        render "spree/api/logger/log", status: 200

      end

      def destroy
        @like = Dish::Like.find_by(user_id: current_user_id, product_id: params[:product_id])

        if @like.destroy
          @status = [ { "messages" => "Like was successfully destroyed"}]

        else
          @status = [ { "messages" => "Like was not successfully destroyed"}]
        end
        render "spree/api/logger/log", status: 200

      end

      private

      def current_user_id
        current_api_user.id
      end
    end
  end
end

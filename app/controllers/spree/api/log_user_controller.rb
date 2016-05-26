module Spree
  module Api
    class LogUserController < Spree::Api::BaseController
      before_action :authenticate_user, :except => [:login]
      def login
        @user = Spree.user_class.find_for_database_authentication(:email => params[:email])
        if  @user && @user.valid_password?(params[:password])
          sign_in(@user)
          @user.generate_spree_api_key!
          render "spree/api/users/show", status: 200
        else
          @status = [{ "messages" => "Your Email or Password is wrong"}]
          render "spree/api/logger/log", status: 404
        end
      end

      def logout
        @user = Spree.user_class.find_for_database_authentication(:spree_api_key => request.headers['X-Spree-Token'])
        if @user
          sign_out(@user)
          @user.generate_spree_api_key!
          @status = [ { "messages" => "Logout successful"}]
          render "spree/api/logger/log", status: 200
        else
          @status = [ { "messages" => "API-Key isn't valuable"}]
          render "spree/api/logger/log", status: 404
        end
      end

      def check
        @user = Spree.user_class.find_for_database_authentication(:email => params[:email])
        if @user
          @status = [{ "messages" => "true"}]
        else
          @status = [{ "messages" => "false"}]
        end
        render "spree/api/logger/log"
      end
    end
  end
end
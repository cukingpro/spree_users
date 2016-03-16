Spree::Api::BaseController.class_eval do

  attr_accessor :current_user_id

  before_action :load_user_id

  def load_user_id
    @current_user_id = current_api_user ? current_api_user.id : nil
  end

  def current_user_id
    @current_user_id
  end

end

Spree::Api::UsersController.class_eval do
  #include Spree::OrdersImporter
  before_action :authenticate_user, :except => [:create, :reset_password, :reset_new_password, :forgot_password]
  def create
    if Spree.user_class.exists?(email: user_params[:email])
      @status = [ { "messages" => "An user already exists for this email address"}]
      render "spree/api/logger/log", status: 409
    else
      if @user = Spree.user_class.create(user_params)
        sign_in(@user)
        @user.generate_spree_api_key!
        UserMailer.welcome_email(@user).deliver
        render "spree/api/users/show", status: 201
      else
        invalid_resource!(@user)
      end
    end
  end

  def edit
    @user = current_api_user

    render "spree/api/users/edit", status: 200

  end

  def show
    @user = user
    render  "spree/api/users/show", status: 200
  end

  def update
    @user = current_api_user
    authorize! :update, @user

    if params[:password].present?

      if @user.change_password(password_params)
        @status = [ { "messages" => "Your password was successfully updated"}]
      else
        @status = [ { "messages" => "Your password was incorect"}]
      end

    elsif params[:user].present?

      if user_information_params[:email] == @user.email

        if  @user.update(user_information_params)
          @status = [ { "messages" => "Your information was successfully updated"}]
        else
          @status = [ { "messages" => "Your information was not successfully updated"}]
        end

      else

        if @user.update_information_with_email_change(user_information_params)
          UserMailer.email_change_confirmation_email(@user).deliver
          @status = [ { "messages" => "Your information was successfully updated. Please confirm your new email"}]
        else
          @status = [ { "messages" => "Your information was not successfully updated"}]
        end

      end

    end

    render "spree/api/logger/log"

  end

  def forgot_password
    @user = Spree::User.find_by!(email: params[:email])
    raw, enc = Devise.token_generator.generate(Spree::User, :reset_password_token)
    @user.reset_password_token = enc
    @user.reset_password_sent_at = Time.now.utc
    @user.save
    UserMailer.forgot_password_email(@user).deliver
    @status = [{"messages" => "Request Successful"}]
    render "spree/api/logger/log" , status: 200
  end

  def reset_password
    @user = Spree::User.find_by!(id: reset_password_params[:id], reset_password_token: reset_password_params[:token])
    @user.password = reset_password_params[:new_password]
    @user.reset_password_token = nil
    @user.save
    UserMailer.password_change_email(@user).deliver
    @status = [ { "messages" => "Reset Password Successful"}]
    render "spree/api/logger/log", status: 200
  end

  def confirm_email_change
    @user = Spree::User.find_by!(id: confirm_email_change_params[:id], email_change_token:  confirm_email_change_params[:token])
    if @user.confirm_email_change
      @status = [ { "messages" => "Your email was successfully updated"}]
    else
      @status = [ { "messages" => "Your email was not successfully updated"}]
    end
    render "spree/api/logger/log", status: 200
  end

  def user_info 
    @user = current_api_user
    render  "spree/api/users/show", status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def user_information_params
    params.require(:user).permit(:first_name, :last_name, :birth_day, :email)
  end

  def password_params
    params.require(:password).permit(:old, :new)
  end

  def reset_password_params
    params.require(:password).permit(:id, :token, :new_password)
  end

  def confirm_email_change_params
    params.require(:confirm_email_change).permit(:id, :token)
  end

end

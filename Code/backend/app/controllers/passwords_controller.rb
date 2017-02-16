class PasswordsController < ApplicationController
  skip_before_action :authenticate_user
  skip_after_action :verify_authorized

  def create
    password_manager.send_token(create_params)
    head :no_content
  end

  def update
    present password_manager.reset_password(update_params)
  end

  private

  def create_params
    params.permit(:email)
  end

  def update_params
    params.permit(%i(reset_password_token password))
  end

  def password_manager
    PasswordManager.new
  end
end

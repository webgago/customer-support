class UsersController < ApplicationController
  before_action :authorize_resource
  skip_before_action :authenticate_user, only: :create

  def index
    present(paginate(search(search_params)))
  end

  def create
    user_manager.create_customer(signup_params)
    head :created
  end

  def destroy
    user_manager.destroy(record)
  end

  private

  def authorize_resource
    return authorize(:user) if no_resource?
    authorize record
  end

  def signup_params
    params.permit(
      :email, :password, :first_name, :last_name
    )
  end

  def search_params
    params.permit(:status, :q)
  end

  def user_manager
    UserManager.new
  end
end

# UserManager is responsible for managing users
class UserManager < ApplicationManager
  # @param [Hash] signup_params
  def create_customer(signup_params)
    with_transaction do
      User.create!(signup_params.to_h.update(role: User::ROLE.customer))
    end
  end

  # destroys the user
  # @param [User] user
  def destroy(user)
    user.destroy!
  end
end

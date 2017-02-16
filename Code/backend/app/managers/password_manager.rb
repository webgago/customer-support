# PasswordManager is responsible for
# sending and reseting passwords
class PasswordManager < ApplicationManager
  # @param [Hash] params
  def send_token(params)
    with_transaction do
      user = User.find_by(email: params[:email])

      if user
        generate_reset_password_token_for(user)
        mail_reset_password_instructions(user)
        user.reset_password_token
      end
    end
  end

  # @param [Hash] params
  def reset_password(params)
    reset_password_token = params[:reset_password_token]
    password = params[:password]
    update_password(reset_password_token, password)
  end

  private

  def update_password(reset_password_token, password)
    with_transaction do
      user = User.find_by! reset_password_token: reset_password_token
      user.update! password: password, reset_password_token: nil
      user
    end
  end

  def generate_reset_password_token_for(user)
    user.update! reset_password_token: generate_unique_secure_token
  end

  def mail_reset_password_instructions(user)
    PasswordMailer.reset_password_instructions(user).deliver_later
  end

  def generate_unique_secure_token
    SecureRandom.base58(24)
  end
end

module Authentication
  extend ActiveSupport::Concern

  include Knock::Authenticable

  included do
    before_action :authenticate_user
  end
end

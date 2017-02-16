module Caching
  extend ActiveSupport::Concern

  include AbstractController::Caching
  include ActionController::Caching
end

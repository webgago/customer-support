class ApplicationController < ActionController::API
  include ApiCommon
  include ErrorHandling
  include Authentication
  include InheritedResource
  include Authorization
  include Searching
  include Pagination
  include Presentation
  include Caching
end

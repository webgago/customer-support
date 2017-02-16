module Searching
  extend ActiveSupport::Concern

  private

  def search(params)
    search_class.new(params).search
  end

  def search_class_name
    controller_name.pluralize.camelize
  end

  def search_class
    "#{search_class_name}Search".constantize
  end
end

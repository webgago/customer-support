module InheritedResource
  extend ActiveSupport::Concern

  private

  # override this to get inherited resources
  def resource_scope
    resource_class.all
  end

  def scope
    resource_scope
  end

  def record
    @record ||= scope.find(params[:id])
  end
end

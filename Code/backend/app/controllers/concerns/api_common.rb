module ApiCommon
  extend ActiveSupport::Concern

  private

  def no_resource?
    action.index? || action.create?
  end

  def action
    params[:action].inquiry
  end

  def controller_name
    params[:controller]
  end

  def resource_class
    controller_name.singularize.classify.constantize
  end

  def destroying?
    action.destroy?
  end
end

class UserPresenter < ApplicationPresenter
  def full_name
    object.name
  end
end

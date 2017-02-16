class ReplyPresenter < ApplicationPresenter
  def user
    UserPresenter.new(object.user)
  end
end

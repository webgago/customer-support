class TicketPresenter < ApplicationPresenter
  def author
    object.user.name
  end

  def user
    UserPresenter.new(object.user)
  end

  def replies
    ReplyPresenter.decorate(object.replies)
  end

  def closed
    object.status == Ticket::STATUS.closed
  end

  def new
    object.status == Ticket::STATUS.new
  end
end

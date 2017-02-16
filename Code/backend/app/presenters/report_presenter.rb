class ReportPresenter < ApplicationPresenter
  def total
    object.data.count
  end

  def data
    TicketPresenter.decorate(object.data)
  end
end

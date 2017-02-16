class Report
  attr_reader :period, :status, :data, :threshold

  def initialize(period: 1.month.ago.beginning_of_day, status: Ticket::STATUS.closed)
    @period = [period, Time.current]
    @status = status
    @data = search
    @threshold = 2.days
  end

  private

  def params
    {
      status: @status,
      closed_at_from: @period.first,
      closed_at_to: @period.last,
      closed_at: :asc
    }
  end

  def search
    query = TicketsSearch.new(params).search
    count_query = TicketsSearch.new(params).search.search_type(:count)
    query.offset(0).limit(count_query.total).to_a
  end
end

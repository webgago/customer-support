# TicketManager is responsible for
# creating, changing statuses of and replying to tickets
class TicketManager < ApplicationManager
  # @param [String] title
  # @param [String] body
  def create(title, body)
    @current_user.tickets.create!(title: title, body: body, status: Ticket::STATUS.new)
  end

  # creates Reply and updates ticket's status if not empty
  # @param [Ticket] ticket
  # @param [String] reply reply's body
  # @param [String] status @see Ticket::STATUS
  def reply(ticket, reply, status)
    with_transaction do
      ticket.replies.create!(body: reply, user: @current_user)
      ticket.update!(status: status) if status.present?
    end
  end

  # sets ticket's status to Ticket::STATUS.open
  # @param [Ticket] ticket
  def reopen(ticket)
    ticket.update!(status: Ticket::STATUS.open)
  end

  # sets ticket's status to Ticket::STATUS.closed
  # and closed_at to current time
  # @param [Ticket] ticket
  def close(ticket)
    ticket.update!(status: Ticket::STATUS.closed, closed_at: Time.current)
  end

  # destroys the ticket
  # @param [Ticket] ticket
  def destroy(ticket)
    ticket.destroy!
  end
end

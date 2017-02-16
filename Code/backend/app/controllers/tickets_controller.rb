class TicketsController < ApplicationController
  before_action :authorize_resource

  def index
    present(paginate(search(search_params)))
  end

  def show
    present(record)
  end

  def create
    record = ticket_manager.create(*create_params)
    present(record)
    render :show
  end

  def reply
    ticket_manager.reply(record, *reply_params)
    present(record)
    render :show
  end

  def reopen
    ticket_manager.reopen(record)
    present(record)
    render :show
  end

  def close
    ticket_manager.close(record)
    present(record)
    render :show
  end

  def destroy
    ticket_manager.destroy(record)
  end

  private

  def authorize_resource
    return authorize(:ticket) if no_resource?
    authorize record
  end

  def ticket_manager
    TicketManager.new(current_user)
  end

  def create_params
    params.permit(:title, :body).values_at(:title, :body)
  end

  def reply_params
    params.permit(:reply, :status).values_at(:reply, :status)
  end

  def search_params
    params.permit(:status, :q).tap do |p|
      p[:updated_at] = :desc
      p.merge!(user_id: current_user.id) unless policy(:ticket).unfiltered_search?
    end
  end
end

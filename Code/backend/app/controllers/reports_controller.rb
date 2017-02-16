class ReportsController < ApplicationController
  before_action :authorize_resource

  def show
    present(report)
  end

  private

  def authorize_resource
    authorize(:reports)
  end

  def report
    Report.new
  end
end

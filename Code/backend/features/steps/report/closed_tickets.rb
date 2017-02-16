class Spinach::Features::ReportClosedTickets < Spinach::FeatureSteps
  When 'I get the report' do
    get report_url
  end

  private

  def schema
    'report'
  end
end

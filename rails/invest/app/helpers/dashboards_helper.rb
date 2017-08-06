# frozen_string_literal: true

module DashboardsHelper
  include Graphs::Forecast
  include Graphs::Investiment
  
  def goal_type_description(goal)
    return 'de Renda' if goal.is_a? Rent
    return 'Total' if goal.is_a? Amount
  end
end

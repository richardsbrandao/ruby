# frozen_string_literal: true

module DashboardsHelper
  def goal_type_description(goal)
    return 'de Renda' if goal.is_a? Rent
    return 'Total' if goal.is_a? Amount
  end
end

class DashboardsController < ApplicationController
  def home
  	@goals = Goal.all
  end
end

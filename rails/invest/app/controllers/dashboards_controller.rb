# frozen_string_literal: true

class DashboardsController < ApplicationController
  def home
    @goals = Goal.all
  end
end

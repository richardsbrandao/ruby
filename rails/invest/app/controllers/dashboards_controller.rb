# frozen_string_literal: true

class DashboardsController < ApplicationController
  helper DashboardsHelper

  def home
    @goals = Goal.all
  end
end

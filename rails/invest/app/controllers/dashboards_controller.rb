# frozen_string_literal: true

class DashboardsController < ApplicationController
  helper DashboardsHelper

  def home
    @goals = Goal.cached_all
  end
end

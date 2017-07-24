# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  helper DashboardsHelper

  def home
    @goals = Goal.cached_all
  end
end

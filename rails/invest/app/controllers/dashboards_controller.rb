# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  helper DashboardsHelper

  def home
    @goals = Goal.cached_all
  end

  def investiments
    # Liquidez (Pizza), Tipo (Pizza), Imposto (Pizza), Valores (Mes a Mes), Objetivo (Mes a Mes), 
  end
end

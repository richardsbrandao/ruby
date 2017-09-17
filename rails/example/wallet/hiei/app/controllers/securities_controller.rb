class SecuritiesController < ApplicationController
  before_action :set_security, only: [:show, :update, :destroy]

  # GET /securities
  # GET /securities.json
  def index
    @securities = Security.all

    render json: @securities
  end

  # GET /securities/1
  # GET /securities/1.json
  def show
    if @security.present?
      render json: @security
    else
      render json: ErrorSerializer.to_404('Security'), status: :not_found
    end
  end

  # POST /securities
  # POST /securities.json
  def create
    @security = new_security_with_params

    if @security.is_a?(Security)
      if @security.save
        render json: @security, status: :created, location: @security
      else
        render json: ErrorSerializer.to_422('Security', @security.errors.messages), status: :unprocessable_entity
      end
    else
      render json: ErrorSerializer.to_400('Security', @messages), status: :bad_request
    end
  end

  # PATCH/PUT /securities/1
  # PATCH/PUT /securities/1.json
  def update
    if @security.present?
      if @security.update(security_params)
        head :no_content
      else
        render json: ErrorSerializer.to_422('Security', @security.errors.messages), status: :unprocessable_entity
      end
    else
      render json: ErrorSerializer.to_404('Security'), status: :not_found
    end
  end

  private

  def new_security_with_params
    Security.new(security_params)
  rescue ArgumentError => e
    @messages = [e.message]
  end

  def set_security
    @security = Security.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
  end

  def security_params
    params.permit(:name, :indexer_id, :tax_type, :expiration, :yield_type)
  end
end

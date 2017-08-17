class IndexersController < ApplicationController
  before_action :set_indexer, only: [:show]

  # GET /indexers
  # GET /indexers.json
  def index
    @indexers = Indexer.all

    render json: @indexers
  end

  # GET /indexers/1
  # GET /indexers/1.json
  def show
    if @indexer.present?
      render json: @indexer
    else
      render json: ErrorSerializer.to_404('Indexer'), status: :not_found
    end
  end

  # POST /indexers
  # POST /indexers.json
  def create
    @indexer = Indexer.new(indexer_params)

    if @indexer.save
      render json: @indexer, status: :created, location: @indexer
    else
      render json: ErrorSerializer.to_422('Indexer', @indexer.errors.messages), status: :unprocessable_entity
    end
  end

  private

  def set_indexer
    begin
      @indexer = Indexer.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
    end
  end

  def indexer_params
    params.permit(:name, :description)
  end
end

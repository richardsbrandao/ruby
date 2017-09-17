class VariationsController < ApplicationController
  before_action :set_variation, only: [:destroy]
  before_action :set_indexer, only: [:index, :create, :destroy]

  # GET /variations
  # GET /variations.json
  def index
    if @indexer.present?
      @variations = @indexer.variations
      render json: @variations
    else
      render json: ErrorSerializer.to_404('Indexer'), status: :not_found
    end
  end

  # POST /variations
  # POST /variations.json
  def create
    if @indexer.present?
      @variation = Variation.new(variation_params)

      if @variation.save
        render json: @variation, status: :created # Ver como resolver o location
      else
        render json: ErrorSerializer.to_422('Variation', @variation.errors.messages), status: :unprocessable_entity
      end
    else
      render json: ErrorSerializer.to_404('Indexer'), status: :not_found
    end
  end

  # DELETE /variations/1
  # DELETE /variations/1.json
  def destroy
    if @indexer.present?
      if @indexer.belongs_to(@variation)
        @variation.destroy
        head :no_content
      else
        render json: ErrorSerializer.to_404('Variation'), status: :not_found
      end
    else
      render json: ErrorSerializer.to_404('Indexer'), status: :not_found
    end
  end

  private

  def set_indexer
    @indexer = Indexer.find(params['indexer_id'])
  rescue ActiveRecord::RecordNotFound => e
  end

  def set_variation
    @variation = Variation.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
  end

  def variation_params
    params.permit(:year, :month, :percent, :indexer_id)
  end
end

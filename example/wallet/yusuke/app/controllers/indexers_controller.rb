class IndexersController < ApplicationController
  def index
    @indexers = Wallet::Connector.find_indexers
  end

  def show
    @indexer = Wallet::Connector.find_indexer(params[:id])
    @variations = Wallet::Connector.find_variations_by_indexer(params[:id])
  end

  def new
    @result = []
  end

  def create
    @result = Wallet::Connector.create(params)

    respond_to do |format|
      if( @result[:id].present? )
        format.html { redirect_to indexers_index_path, notice: 'Indice foi criado com sucesso!' }
      else
        format.html { render :new }
      end
    end
  end

end

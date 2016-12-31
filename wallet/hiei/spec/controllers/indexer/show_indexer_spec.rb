require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe IndexersController, type: :request do
  let(:indexer) { create(:ipca) }

  describe '#show' do
    context 'sucessful to find indexer' do
      it 'must show a indexer' do
        get "/indexers/#{indexer.id}", {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['id']).to eq(indexer.id)
        expect(parsed_response['name']).to eq('IPCA')
        expect(parsed_response['description']).to eq('Indice oficial de Inflação no Brasil')
      end
    end

    context 'error find invalid indexer' do
      it 'must not create a indexer without name' do
        get '/indexers/nao_existe', {}

        expect(response).to have_http_status(:not_found)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Indexer Not Found')
        expect(parsed_response['http_status']).to eq(404)
      end
    end
  end
end

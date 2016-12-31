require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe IndexersController, type: :request do
  describe '#index' do
    context 'find all indexer' do
      it 'must show a indexer' do
        get '/indexers', {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse.size).to eq(3)
        expect(parsedResponse[0]['name']).to eq('SELIC')
        expect(parsedResponse[1]['name']).to eq('IPCA')
        expect(parsedResponse[2]['name']).to eq('CDI')
      end
    end
  end
end

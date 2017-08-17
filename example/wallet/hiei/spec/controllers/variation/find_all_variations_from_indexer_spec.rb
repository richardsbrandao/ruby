require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe VariationsController, type: :request do
  describe '#index' do
    let(:selic) { Indexer.find_by(name: 'SELIC') }
    let(:cdi) { Indexer.find_by(name: 'CDI') }

    context 'sucessful cases' do
      it 'should show all variations of valid indexer' do
        get "/indexers/#{selic.id}/variations", {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse.size).to eq(3)
        expect(parsedResponse[0]['year']).to eq(2014)
        expect(parsedResponse[0]['month']).to eq(11)

        expect(parsedResponse[1]['year']).to eq(2014)
        expect(parsedResponse[1]['month']).to eq(12)

        expect(parsedResponse[2]['year']).to eq(2015)
        expect(parsedResponse[2]['month']).to eq(1)
      end
    end

    context 'error cases' do
      it 'should show 404 if inxer not exists' do
        get '/indexers/0/variations', {}

        expect(response).to have_http_status(:not_found)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse['message']).to eq('Indexer Not Found')
        expect(parsedResponse['http_status']).to eq(404)
      end

      it 'should return 200 with empty list if indexer exists and does not have any variation' do
        get "/indexers/#{cdi.id}/variations", {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse.size).to eq(0)
      end
    end
  end
end

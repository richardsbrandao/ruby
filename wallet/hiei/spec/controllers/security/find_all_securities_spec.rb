require 'rails_helper'

RSpec.describe SecuritiesController, type: :request do
  describe '#index' do
    context 'find securities' do
      let(:selic) { Indexer.find_by(name: 'SELIC') }

      it 'find all securities' do
        get '/securities', {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse.size).to eq(2)

        expect(parsedResponse[0]['name']).to eq('Tesouro SELIC 2017')
        expect(parsedResponse[0]['tax_type']).to eq('FIXED_INCOME')
        expect(parsedResponse[0]['expiration']).to eq('2017-03-01')
        expect(parsedResponse[0]['yield_type']).to eq('DAILY')
        expect(parsedResponse[0]['indexer_id']).to eq(selic.id)
      end
    end
  end
end

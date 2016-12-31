require 'rails_helper'

RSpec.describe SecuritiesController, type: :request do
  describe '#index' do
    context 'find securities' do
      let(:security) { Security.find_by(name: 'Tesouro SELIC 2017') }

      it 'find security by id' do
        get "/securities/#{security.id}", {}

        expect(response).to be_success
        expect(response).to have_http_status(:ok)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['name']).to eq('Tesouro SELIC 2017')
        expect(parsed_response['tax_type']).to eq('FIXED_INCOME')
        expect(parsed_response['expiration']).to eq('2017-03-01')
        expect(parsed_response['yield_type']).to eq('DAILY')
      end
    end

    context 'error find security by id' do
      it 'can\'t find security by invalid id' do
        get '/securities/0', {}

        expect(response).to have_http_status(:not_found)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['message']).to eq('Security Not Found')
        expect(parsed_response['http_status']).to eq(404)
      end
    end
  end
end

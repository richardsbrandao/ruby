require 'rails_helper'

RSpec.describe SecuritiesController, type: :request do
  describe '#index' do
    context 'update securities' do
      let(:selic_2017) { Security.find_by(name: 'Tesouro SELIC 2017') }

      it 'update security' do
        put "/securities/#{selic_2017.id}", name: 'Tesouro SELIC 2021', expiration: '2021-03-01'

        expect(response).to be_success
        expect(response).to have_http_status(:no_content)

        security = Security.find(selic_2017.id)

        expect(security.name).to eq('Tesouro SELIC 2021')
        expect(security.tax_type).to eq('FIXED_INCOME')
        expect(security.expiration).to eq(Date.parse('2021-03-01'))
        expect(security.yield_type).to eq('DAILY')
        expect(security.indexer_id).to eq(Indexer.find_by(name: 'SELIC').id)
      end
    end

    context 'error update securities' do
      let(:selic_2017) { Security.find_by(name: 'Tesouro SELIC 2017') }

      it 'update invalid security' do
        put '/securities/0', { name: 'Tesouro SELIC 2021', expiration: '2021-03-01' }

        expect(response).to have_http_status(:not_found)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['message']).to eq('Security Not Found')
        expect(parsed_response['http_status']).to eq(404)
      end

      it 'update invalid data' do
        put "/securities/#{selic_2017.id}", name: '', expiration: '2021-03-01'

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['http_status']).to eq(422)
        expect(parsed_response['message']).to eq('Error on proccess entity Security')

        expect(parsed_response['errors'].size).to eq(1)
        expect(parsed_response['errors'][0]).to eq('name can\'t be blank')
      end
    end
  end
end

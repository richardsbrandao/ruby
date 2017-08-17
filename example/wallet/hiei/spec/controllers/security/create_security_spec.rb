require 'rails_helper'

require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe SecuritiesController, type: :controller do
  let(:indexer) { create(:selic) }

  describe '#create' do
    context 'create security' do
      it 'must create a security' do
        params = { name: 'Tesouro Selic 2017', indexer_id: indexer.id, tax_type: :FIXED_INCOME, expiration: Date.parse('2017-03-01'), yield_type: :MONTHLY }

        post :create, params

        expect(response).to be_success
        expect(response).to have_http_status(:created)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['name']).to eq('Tesouro Selic 2017')
        expect(parsed_response['tax_type']).to eq('FIXED_INCOME')
        expect(parsed_response['expiration']).to eq('2017-03-01')
        expect(parsed_response['yield_type']).to eq('MONTHLY')
        expect(parsed_response['indexer_id']).to eq(indexer.id)
      end
    end

    context 'error create security' do
      it 'must not create a security without name' do
        params = { indexer_id: indexer.id, tax_type: :FIXED_INCOME, expiration: Date.parse('2017-03-01'), yield_type: :MONTHLY }

        post :create, params

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['http_status']).to eq(422)
        expect(parsed_response['message']).to eq('Error on proccess entity Security')

        expect(parsed_response['errors'].size).to eq(1)
        expect(parsed_response['errors'][0]).to eq('name can\'t be blank')
      end

      it 'must not create a security without valid tax_type' do
        params = { indexer_id: indexer.id, tax_type: :INVALID, expiration: Date.parse('2017-03-01'), yield_type: :MONTHLY }

        post :create, params

        expect(response).to have_http_status(:bad_request)
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['http_status']).to eq(400)
        expect(parsed_response['message']).to eq('Security Is Invalid')

        expect(parsed_response['errors'].size).to eq(1)
        expect(parsed_response['errors'][0]).to eq('\'INVALID\' is not a valid tax_type')
      end
    end
  end
end

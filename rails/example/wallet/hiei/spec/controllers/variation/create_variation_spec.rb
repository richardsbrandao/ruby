require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe VariationsController, type: :request do
  let(:indexer) { create(:ipca) }

  describe '#index' do
    context 'successful cases' do
      it 'must create a variation' do
        params = { month: 11, year: 2015, percent: 2.1, indexer_id: indexer.id }

        post "/indexers/#{indexer.id}/variations", params

        expect(response).to be_success
        expect(response).to have_http_status(:created)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to be_a_kind_of(Fixnum)
        expect(parsed_response['indexer_id']).to eq(indexer.id)
        expect(parsed_response['month']).to eq(11)
        expect(parsed_response['year']).to eq(2015)
        expect(parsed_response['percent']).to eq(2.1)
      end
    end

    context 'errors cases' do
      it 'must invalidate creation with invalid data' do
        params = { month: 11, percent: 2.1 }

        post "/indexers/#{indexer.id}/variations", params

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Error on proccess entity Variation')
        expect(parsed_response['http_status']).to eq(422)

        expect(parsed_response['errors'].size).to eq(2)
        expect(parsed_response['errors'][0]).to eq('year can\'t be blank')
        expect(parsed_response['errors'][1]).to eq('year is not a number')
      end

      it 'must invalidate creation with invalid indexer' do
        params = { month: 11, year: 2015, percent: 2.1 }

        post '/indexers/0/variations', params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Indexer Not Found')
        expect(parsed_response['http_status']).to eq(404)
      end
    end
  end
end

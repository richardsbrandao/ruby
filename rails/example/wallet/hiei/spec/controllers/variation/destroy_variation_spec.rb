require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe VariationsController, type: :request do
  let(:indexer) { Indexer.find_by(name: 'IPCA') }
  let(:selic) { Indexer.find_by(name: 'SELIC') }

  describe '#show' do
    context 'successful cases' do
      it 'must delete a variation' do
        delete "/indexers/#{indexer.id}/variations/#{indexer.variations[0].id}", {}

        expect(response).to be_success
        expect(response).to have_http_status(:no_content)

        expect { Variation.find(indexer.variations[0].id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'errors cases' do
      it 'should show an error when indexer does not exist' do
        delete "/indexers/0/variations/#{Variation.all.first.id}", {}

        expect(response).to have_http_status(:not_found)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse['message']).to eq('Indexer Not Found')
        expect(parsedResponse['http_status']).to eq(404)
      end

      it 'should show an error when variation does not exist' do
        delete "/indexers/#{indexer.id}/variations/0", {}

        expect(response).to have_http_status(:not_found)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse['message']).to eq('Variation Not Found')
        expect(parsedResponse['http_status']).to eq(404)
      end

      it 'should not delete if variation belongs to another indexer' do
        delete "/indexers/#{indexer.id}/variations/#{Variation.where(indexer_id: selic.id).first.id}", {}

        expect(response).to have_http_status(:not_found)

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse['message']).to eq('Variation Not Found')
        expect(parsedResponse['http_status']).to eq(404)
      end
    end
  end
end

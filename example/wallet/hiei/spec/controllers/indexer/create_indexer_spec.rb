require 'rails_helper'

RSpec.describe IndexersController, type: :controller do
  describe '#create' do
    context 'create indexer' do
      it 'must create a indexer' do
        params = { name: 'Selic', description: 'Taxa de Juros básica' }

        post :create, params

        expect(response).to be_success
        expect(response).to have_http_status(:created)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['id']).to be_a_kind_of(Fixnum)
        expect(parsed_response['name']).to eq('Selic')
        expect(parsed_response['description']).to eq('Taxa de Juros básica')

        expect(response.header['Location']).not_to be_empty
      end
    end

    context 'error create indexer' do
      it 'must not create a indexer without name' do
        params = { description: 'Descricao' }

        post :create, params

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['http_status']).to eq(422)
        expect(parsed_response['message']).to eq('Error on proccess entity Indexer')

        expect(parsed_response['errors'].size).to eq(1)
        expect(parsed_response['errors'][0]).to eq('name can\'t be blank')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ErrorSerializer, type: :model do

	it "to 404" do
		error = ErrorSerializer.to_404 'Indexer'

		expect( error[:http_status] ).to eq(404)
		expect( error[:message] ).to eq('Indexer Not Found')
		expect( error[:error] ).to be_nil
	end

	it "to 422" do
		active_record_error = { "year":["can't be blank", "is not a number"] }
		error = ErrorSerializer.to_422 'Indexer', active_record_error

		expect( error[:http_status] ).to eq(422)
		expect( error[:message] ).to eq('Error on proccess entity Indexer')
		expect( error[:errors].size ).to eq(2)

		expect( error[:errors][0] ).to eq("year can't be blank")
		expect( error[:errors][1] ).to eq("year is not a number")
  end

	it "to 422" do
		error_message = ['there is a error']
		error = ErrorSerializer.to_400('Security', error_message )

		expect( error[:http_status] ).to eq(400)
		expect( error[:message] ).to eq('Security Is Invalid')
		expect( error[:errors].size ).to eq(1)

		expect( error[:errors][0] ).to eq("there is a error")
	end


end

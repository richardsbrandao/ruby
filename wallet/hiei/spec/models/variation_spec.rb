require 'rails_helper'

RSpec.describe Variation, type: :model do
  it 'valid variation' do
    variation = Variation.new(year: 2014, month: 11, percent: 1.04)

    expect(variation.valid?).to be(true)
  end

  it 'must invalidate all fields' do
    variation = Variation.new
    expect(variation.valid?).to be(false)

    expect(variation.errors.full_messages.size).to eq(7)

    expect(variation.errors.full_messages[0]).to eq("Year can't be blank")
    expect(variation.errors.full_messages[1]).to eq('Year is not a number')
    expect(variation.errors.full_messages[2]).to eq("Month can't be blank")
    expect(variation.errors.full_messages[3]).to eq('Month is not a number')
    expect(variation.errors.full_messages[4]).to eq('Month is not included in the list')
    expect(variation.errors.full_messages[5]).to eq("Percent can't be blank")
    expect(variation.errors.full_messages[6]).to eq('Percent is not a number')
  end
end

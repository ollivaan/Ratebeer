require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "beer has saved when it has name and style" do
    beer = Beer.create name:"Kalja", style:"Kalja1"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved when style isnt given" do
    beer = Beer.create style:nil

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)

  end


  it "is not saved when name isnt given" do
    beer = Beer.create name:nil

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end


end

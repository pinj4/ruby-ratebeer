require 'rails_helper'

RSpec.describe Beer, type: :model do

  describe "with a brewery" do
    let(:test_brewery1) { Brewery.new name: "test1", year: 2000 }
    
    it "is saved if given the correct information" do
      beer = Beer.create name: "test1", style: "Lager", brewery: test_brewery1
    
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved if not given a name" do
    beer = Beer.create style:"Lager", brewery: test_brewery1

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
    end

    it "is not saved if not given a style" do
      beer = Beer.create name:"test1", brewery: test_brewery1
  
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end


require 'rails_helper'

describe "Beers page" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

  before :each do
    visit beers_path
  end

  it "can add new beer" do
    click_link "New beer"
   # fill_in('beer_name', with: "testbeer")
    fill_in('beer[name]', with: 'test beer')
    select('Lager', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
        click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)
  end

  it "doesnt add beer if name not valid" do
    click_link "New beer"
    fill_in('beer[name]', with: '')
    select('Lager', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')

    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end
end
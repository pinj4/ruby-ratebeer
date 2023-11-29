require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end
      
    Capybara.javascript_driver = :chrome
    WebMock.allow_net_connect!
  end
  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", :js => true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "is in alphabetical order by name", :js => true do
    visit beerlist_path
    first = find('#beertable').first('.tablerow')
    expect(first).to have_content("Fastenbier")
  end

  it "is in alphabetical order by style after clicking on style", :js => true do
    visit beerlist_path
    find('#style').click
    first = find('#beertable').first('.tablerow')
    expect(first).to have_content("Nikolai")
  end

  it "is in alphabetical order by brewery name after clicking on brewery", :js => true do
    visit beerlist_path
    find('#brewery').click
    first = find('#beertable').first('.tablerow')
    expect(first).to have_content("Lechte Weisse")
  end
end
module Helpers
  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
    
  def create_beer_with_rating(object, score)
    style = FactoryBot.create(:style, name: style)
    beer = FactoryBot.create(:beer, style: style)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
   end

  def create_beer_with_rating_and_style(object, score, style)
    style = FactoryBot.create(:style, name: style)
    beer = FactoryBot.create(:beer, style: style)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end

  def create_beer_with_rating_and_brewery(object, score, brewery)
    brewery = FactoryBot.create(:brewery, name: brewery)
    beer = FactoryBot.create(:beer, brewery: brewery)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
    create_beer_with_rating(object, score)
    end
  end
end

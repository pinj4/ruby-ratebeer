require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too a short password" do
    user = User.create username: "Pekka", password: "s", password_confirmation: "s"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password consisting only of lowercase letters" do
    user = User.create username: "Pekka", password: "secret", password_confirmation: "secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end


  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }


    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end

    describe "favorite beer" do
      let(:user){ FactoryBot.create(:user) }

      it "has method for determining the favorite beer" do
        expect(user).to respond_to(:favorite_beer)
      end

      it "without ratings does not have a favorite beer" do
        expect(user.favorite_beer).to eq(nil)
      end

      it "is the only rated if only one rating" do
        beer = FactoryBot.create(:beer)
        rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

        expect(user.favorite_beer).to eq(beer)
      end

      it "is the one with highest rating if several rated" do
        create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
        best = create_beer_with_rating({ user: user }, 25 )

        expect(user.favorite_beer).to eq(best)
      end
    end
# describe User

    describe "favorite style" do
      let(:user){ FactoryBot.create(:user) }
  
      it "has method for determining the favorite style" do
        expect(user).to respond_to(:favorite_style)
      end

      it "without ratings does not have a favorite style" do
        expect(user.favorite_style).to eq(nil) 
      end

      it "is the only rated if only one rating" do
        beer = FactoryBot.create(:beer)
        rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

        expect(user.favorite_style).to eq(beer.style)
      end

      it "is the one with highest avg rating if several rated" do
        create_beers_with_many_ratings({user: user}, 10, 10, 20)
        best = create_beer_with_rating_and_style({user: user}, 50, "IPA")

        expect(user.favorite_style).to eq(best.style)
      end
    end

    describe "favorite brewery" do
      let(:user){ FactoryBot.create(:user) }
      it "has method for determining the favorite style" do
        expect(user).to respond_to(:favorite_style)
      end

      it "without ratings does not have a favorite brewery" do
        expect(user.favorite_brewery).to eq(nil) 
      end

      it "is the only rated if only one rating" do
        beer = FactoryBot.create(:beer)
        rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

        expect(user.favorite_brewery).to eq(beer.brewery.name)
      end

      it "is the one with highest avg rating if several rated" do
        create_beers_with_many_ratings({user: user}, 10, 10, 20)
        best = create_beer_with_rating_and_brewery({user: user}, 50, "lemppari")

        expect(user.favorite_brewery).to eq(best.brewery.name)
      end
    end
  end
end

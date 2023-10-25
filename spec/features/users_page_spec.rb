require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username: 'Pekka2'}
  #before :each do
   # FactoryBot.create :user
  #end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")
  
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')
      
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    it "shows all of users ratings" do
      create_beers_with_many_ratings({user: user}, 10, 20, 30)
      create_beers_with_many_ratings({user: user2}, 40, 50)

      visit user_path(user)
      expect(page).to have_content "anonymous 10"
      expect(page).to have_content "anonymous 20"
      expect(page).to have_content "anonymous 30"
      expect(page).to have_content "3 ratings"
    end

    it "deletes a rating" do
      sign_in(username: "Pekka", password: "Foobar1")
      create_beers_with_many_ratings({user: user}, 10, 20, 30)
      visit user_path(user)
      page.all('a')[9].click
      expect(page).to have_content "anonymous 20"
      expect(page).to have_content "anonymous 30"
      expect(page).to have_content "2 ratings"
    end

    it "doesn't show a favorite brewery without ratings" do
      sign_in(username: "Pekka", password: "Foobar1")
      visit user_path(user)
    expect(page).to have_content "user doesn't have a favorite brewery yet"
    end

    it "shows user's favorite brewery" do
      create_beers_with_many_ratings({user: user}, 10, 10, 20)
      best = create_beer_with_rating_and_brewery({user: user}, 50, "lemppari")

      sign_in(username: "Pekka", password: "Foobar1")
      visit user_path(user)
      expect(page).to have_content "Favorite brewery: lemppari"
    end

    it "doesn't show a favorite style without ratings" do
      sign_in(username: "Pekka", password: "Foobar1")
      visit user_path(user)
    expect(page).to have_content "user doesn't have a favorite style yet"
    end

    it "shows user's favorite style" do
      create_beers_with_many_ratings({user: user}, 10, 10, 20)
      best = create_beer_with_rating_and_style({user: user}, 50, "IPA")
      
      sign_in(username: "Pekka", password: "Foobar1")
      visit user_path(user)
      expect(page).to have_content "Favorite style: IPA"
    end

  end
end
require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end




  it "is not saved when password is too short" do
    user = User.create username:"Pekka", password:"pe", password_confirmation:"pe"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved when there is no numbers in password" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)

    end

  end
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end
  # describe "favorite style" do
  #   let(:user) { FactoryGirl.create(:user)}
  #   it "has method for determining the favorite style" do
  #     expect(user).to respond_to(:favorite_style)
  #   end
  #
  #   it "doesn't exist if user hasn't rated any beers" do
  #     expect(user.favorite_style).to eq(nil)
  #   end
  #
  #   it "with only one beer rated returns that beer's style" do
  #     beer = create_beer_with_rating(user, 10)
  #
  #     expect(user.favorite_style).to eq("Lager")
  #   end
  #
  #   it "returns the highest rated style when having one of each style rated" do
  #     beer1 = FactoryGirl.create(:beer)
  #     beer2 = FactoryGirl.create(:beer2)
  #     beer3 = FactoryGirl.create(:beer3)
  #
  #     rating1 = FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
  #     rating2 = FactoryGirl.create(:rating, score:15, beer:beer2, user:user)
  #     rating3 = FactoryGirl.create(:rating, score:20, beer:beer3, user:user)
  #
  #     expect(user.favorite_style).to eq("Pale ale")
  #   end
  #
  #   it "returns the highest rated style when having multiple of styles rated" do
  #     beer1 = FactoryGirl.create(:beer)
  #     beer2 = FactoryGirl.create(:beer)
  #     beer3 = FactoryGirl.create(:beer)
  #
  #     beer4 = FactoryGirl.create(:beer2)
  #     beer5 = FactoryGirl.create(:beer2)
  #     beer6 = FactoryGirl.create(:beer2)
  #
  #     beer7 = FactoryGirl.create(:beer3)
  #     beer8 = FactoryGirl.create(:beer3)
  #
  #     rating1 = FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
  #     rating2 = FactoryGirl.create(:rating, score:15, beer:beer2, user:user)
  #     rating3 = FactoryGirl.create(:rating, score:20, beer:beer3, user:user)
  #
  #     rating4 = FactoryGirl.create(:rating, score:30, beer:beer4, user:user)
  #     rating5 = FactoryGirl.create(:rating, score:35, beer:beer5, user:user)
  #     rating6 = FactoryGirl.create(:rating, score:40, beer:beer6, user:user)
  #
  #     rating7 = FactoryGirl.create(:rating, score:20, beer:beer7, user:user)
  #     rating8 = FactoryGirl.create(:rating, score:25, beer:beer8, user:user)
  #
  #     expect(user.favorite_style).to eq("Weizen")
  #   end
  # end
end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating user, score
    end
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
    beer
  end


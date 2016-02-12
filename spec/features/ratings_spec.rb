require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
    # visit signin_path
    # fill_in('username', with:'Pekka')
    # fill_in('password', with:'Foobar1')
    # click_button('Log in')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when exists multiple different users with ratings" do
    let!(:user2) { FactoryGirl.create(:user, username:"Kalle") }
    let!(:rating1) { FactoryGirl.create(:rating, score:20, beer:beer1, user:user) }
    let!(:rating2) { FactoryGirl.create(:rating, score:40, beer:beer2, user:user2) }

    it "all ratings show up correctly on ratings page" do
      visit ratings_path

      expect(page).to have_content "List of ratings"
      expect(page).to have_content "Number of ratings 2"
      expect(page).to have_content "#{beer1.name} 20"
      expect(page).to have_content "#{beer2.name} 40"
    end

    it "user ratings show up correctly on his page" do
      visit user_path(user)

      expect(page).to have_content user.username
      expect(page).to have_content "Has made 1 rating"
      expect(page).to have_content "#{beer1.name} 20"
      expect(page).not_to have_content "#{beer2.name} 40"
    end
  end
  end

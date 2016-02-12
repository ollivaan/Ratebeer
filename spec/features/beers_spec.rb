require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create :user
  end

  describe "when user signed in" do
    before :each do
      sign_in(username:"Pekka", password:"Foobar1")
    end
    describe "when brewery exists" do
      before :each do
        @brewery = FactoryGirl.create :brewery
      end
      it "can create beer with name" do
        visit new_beer_path
        fill_in('beer[name]', with:"Olut")
        click_button('Create Beer')

        expect(current_path).to eq(beers_path)
        expect(page).to have_content 'Beer was successfully created'
        #
        expect(@brewery.beers.count).to be(1)
      end

      it "can not create beer: invalid name" do
        visit new_beer_path
        fill_in('beer[name]', with:"")
        click_button('Create Beer')

        expect(page).to have_content 'Name can\'t be blank'
        expect(page).to have_content 'New Beer'
        expect(@brewery.beers.count).to be(0)

      end

  end
  end
  end
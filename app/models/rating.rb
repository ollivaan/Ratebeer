class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  def to_s
    beer = Beer.find_by id:self.beer_id
    "#{beer.name} #{score}"
  end
end

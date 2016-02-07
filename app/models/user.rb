class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, dependent: :destroy
  #has many :beers, through: :ratings
  # käyttäjällä on monta ratingia

end

class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  validates :password, length: { minimum: 4 },
                       format: {
                          with: /\d.*[A-Z]|[A-Z].*\d/,
                          message: "has to contain one number and one upper case letter"
                       }
  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  # def favorite_style
  #   return nil if beers.empty?
  #   styles = Hash.new
  #   ratings.each do |r|
  #     if styles[r.beer.style].nil?
  #       styles[r.beer.style] = Array.new(2)
  #       set_initial_count_and_score(styles, r)
  #     end
  #     styles[r.beer.style][0] += r.score
  #     styles[r.beer.style][1] += 1
  #   end
  #   averages = total_rating_averages(styles)
  #   get_element_with_highest_rating(averages)
  # end

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password
end

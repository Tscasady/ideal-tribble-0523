class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors
end

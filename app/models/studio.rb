class Studio < ApplicationRecord
  has_many :movies
  has_many :actors, through: :movies 

  def uniq_actors
    self.actors.uniq
  end
end

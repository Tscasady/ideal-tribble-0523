require 'rails_helper'

RSpec.describe Movie do

  let!(:studio_1) { Studio.create!(name: "Best Movie Studio", location: "Hollywood") }
  let!(:movie_1) { studio_1.movies.create!(title: "Everything Everywhere", creation_year: 2022, genre: "Drama") }
  let!(:movie_2) { studio_1.movies.create!(title: "Empty movie", creation_year: 2022, genre: "Empty") }
  let!(:actor_1) { movie_1.actors.create!(name: "Michelle Yeoh", age: 60) }
  let!(:actor_2) { movie_1.actors.create!(name: "Stephanie Hsu", age: 32) }
  let!(:actor_3) { movie_1.actors.create!(name: "Ke Huy Quan", age: 51) }

  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many(:actors).through(:movie_actors)}
  end

  describe '#actors_by_age' do
    it 'returns the movies actors from youngest to oldest' do
      expect(movie_1.actors_by_age).to eq([actor_2, actor_3, actor_1])
      expect(movie_2.actors_by_age).to eq([])
    end
  end

  describe '#average_actor_age' do
    it 'returns the movies average actor age' do
      expect(movie_1.average_actor_age.round(2)).to eq(47.67)
      expect(movie_2.average_actor_age.round(2)).to eq(0)
    end
  end
end

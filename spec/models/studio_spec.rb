require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies}
    it {should have_many(:actors).through(:movies)}
  end

  describe '#uniq_actors' do

    let!(:studio_1) { Studio.create!(name: "Best Movie Studio", location: "Hollywood") }
    let!(:studio_2) { Studio.create!(name: "Film Productions", location: "Denver") }
    let!(:studio_3) { Studio.create!(name: "Empty Studio", location: "Nowhere") }
    let!(:movie_1) { studio_1.movies.create!(title: "Everything Everywhere", creation_year: 2022, genre: "Drama") }
    let!(:movie_2) { studio_2.movies.create!(title: "Spiderman #189", creation_year: 2022, genre: "Tired") }
    let!(:movie_3) { studio_1.movies.create!(title: "Die Hard", creation_year: 1988, genre: "Action") }
    let!(:movie_4) { studio_2.movies.create!(title: "Moana", creation_year: 2016, genre: "Animated") }
    let!(:actor_1) { movie_1.actors.create!(name: "Michelle Yeoh", age: 60) }
    let!(:actor_2) { movie_1.actors.create!(name: "Stephanie Hsu", age: 32) }
    let!(:actor_3) { movie_1.actors.create!(name: "Ke Huy Quan", age: 51) }
    let!(:actor_4) { movie_4.actors.create!(name: "Auli'i Cravalho", age: 22) }
    let!(:actor_5) { movie_3.actors.create!(name: "Bruce Willis", age: 67) }
    let!(:actor_6) { movie_3.actors.create!(name: "Bonnie Bedlia", age: 74) }

    let!(:ma1) { MovieActor.create!(movie: movie_3, actor: actor_3) }
    
    it 'returns a list of unique actors that work for the studio' do
      expect(studio_1.uniq_actors).to eq([actor_1, actor_2, actor_3, actor_5, actor_6])
      expect(studio_2.uniq_actors).to eq([actor_4])
      expect(studio_3.uniq_actors).to eq([])
    end
  end
end

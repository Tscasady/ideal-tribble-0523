require 'rails_helper'

RSpec.describe 'The movie show page', type: :feature do

    let!(:studio_1) { Studio.create!(name: "Best Movie Studio", location: "Hollywood") }
    let!(:studio_2) { Studio.create!(name: "Film Productions", location: "Denver") }
    let!(:movie_1) { studio_1.movies.create!(title: "Everything Everywhere", creation_year: 2022, genre: "Drama") }
    let!(:movie_2) { studio_2.movies.create!(title: "Spiderman #189", creation_year: 2022, genre: "Tired") }
    let!(:movie_3) { studio_1.movies.create!(title: "Die Hard", creation_year: 1988, genre: "Action") }
    let!(:movie_4) { studio_2.movies.create!(title: "Moana", creation_year: 2016, genre: "Animated") }
    let!(:actor_1) { movie_1.actors.create!(name: "Michelle Yeoh", age: 60) }
    let!(:actor_2) { movie_1.actors.create!(name: "Stephanie Hsu", age: 32) }
    let!(:actor_3) { movie_1.actors.create!(name: "Ke Huy Quan", age: 51) }

  describe 'when a user visits a movie show page' do
    it 'displays the movies title, creation year, and genre' do
      visit "/movies/#{movie_1.id}"

      expect(page).to have_content "Everything Everywhere"
      expect(page).to have_content "Drama"
      expect(page).to have_content "2022"
    end

    it 'displays a list of all its actors from youngest to oldest' do
      visit "/movies/#{movie_1.id}"

      expect("Stephanie Hsu").to appear_before "Ke Huy Quan"
      expect("Ke Huy Quan").to appear_before "Michelle Yeoh"
    end

    it 'displays the average age of all the movies actors'
  end
end
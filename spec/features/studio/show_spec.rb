require 'rails_helper'

RSpec.describe 'The studio show page', type: :feature do

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

  describe 'when a user visits the studio show page' do
    it 'displays the studios name and location' do
      visit "/studios/#{studio_1.id}"

      expect(page).to have_content "Best Movie Studio"
      expect(page).to have_content "Hollywood"
    end
  
    it 'displays a unique list of all of the actors that have worked for the studio' do
      visit "/studios/#{studio_1.id}"

      expect(page).to have_content "Bruce Willis" 
      expect(page).to have_content "Bonnie Bedlia" 
      expect(page).to have_content "Michelle Yeoh" 
      expect(page).to have_content "Stephanie Hsu" 
      expect(page).to have_content "Ke Huy Quan" 
      expect(page).to_not have_content "Auli'i Cravalho" 
    end

    it 'can display no actors' do
      visit "/studios/#{studio_3.id}"

      expect(page).to_not have_content "Bruce Willis"
      expect(page).to_not have_content "Michelle Yeoh" 
    end

  end
end
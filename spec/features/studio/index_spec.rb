require 'rails_helper'

RSpec.describe 'The studio index page', type: :feature do
  describe 'when a user visists the studio index page' do

    let!(:studio_1) { Studio.create!(name: "Best Movie Studio", location: "Hollywood") }
    let!(:studio_2) { Studio.create!(name: "Film Productions", location: "Denver") }
    let!(:movie_1) { studio_1.movies.create!(title: "Everything Everywhere", creation_year: 2022, genre: "Drama") }
    let!(:movie_2) { studio_2.movies.create!(title: "Spiderman #189", creation_year: 2022, genre: "Tired") }
    let!(:movie_3) { studio_1.movies.create!(title: "Die Hard", creation_year: 1988, genre: "Action") }
    let!(:movie_4) { studio_2.movies.create!(title: "Moana", creation_year: 2016, genre: "Animated") }

    it 'displays all the studios with their names and locations' do
      visit '/studios'
      within("#studio_#{studio_1.id}") do
        expect(page).to have_content "Best Movie Studio" 
        expect(page).to have_content "Hollywood" 
      end

      within("#studio_#{studio_2.id}") do
        expect(page).to have_content "Film Productions" 
        expect(page).to have_content "Denver" 
      end
    end

    it 'displays all the studios movies with their title, creation year, and genre' do
      visit '/studios'

      within("#studio_#{studio_1.id}") do
        expect(page).to have_content "Everything Everywhere" 
        expect(page).to have_content "Die Hard" 
        expect(page).to have_content "2022" 
        expect(page).to have_content "1988" 
        expect(page).to have_content "Action" 
        expect(page).to have_content "Drama" 
      end

      within("#studio_#{studio_2.id}") do
        expect(page).to have_content "Spiderman" 
        expect(page).to have_content "Moana" 
        expect(page).to have_content "2022" 
        expect(page).to have_content "2016" 
        expect(page).to have_content "Animated" 
        expect(page).to have_content "Tired" 
      end
    end
  end
end
require 'rails_helper'

describe Movie do
    let!(:movie1) { FactoryBot.create(:movie, title: 'Jaws', rating: 'PG', director: 'Steven Spielberg') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'E.T.', rating: 'PG', director: 'Steven Spielberg') }
    let!(:movie3) { FactoryBot.create(:movie, title: 'Star Wars IV', rating: 'PG', director: 'George Lucas') }
    let!(:movie4) { FactoryBot.create(:movie, title: 'I do not have a director, I am the sad path', rating: 'PG-13')}
    
    describe 'find_similar' do
        context 'director exists' do
            it 'should return the correct matches for movies by the same director' do
                expect(Movie.find_similar(movie1.title)).to eq(['Jaws', 'E.T.'])
                expect(Movie.find_similar(movie3.title)).to eq(['Star Wars IV'])
            end
            it 'should not return movies by a different director' do
                expect(Movie.find_similar(movie1.title)).to_not include(['Star Wars IV'])
            end
        end
        context 'director does not exist' do
            it 'should return nil' do
                expect(Movie.find_similar(movie4.title)).to eq(nil)
            end
        end
    end
    
    describe 'with_ratings' do
        context 'rating list is empty' do
            it 'should return all movies' do
                expect(Movie.with_ratings(nil)).to eq([movie1, movie2, movie3, movie4])
            end
        end
        context 'rating list contains values' do
            it 'should return all movies that match the rating list' do
                expect(Movie.with_ratings(['PG'])).to eq([movie1, movie2, movie3])
            end
        end
    end
    
    describe 'all_ratings' do
        it 'it should return all ratings that are present in the movie list' do
            expect(Movie.all_ratings()).to eq(['PG','PG-13'])
        end
    end
end
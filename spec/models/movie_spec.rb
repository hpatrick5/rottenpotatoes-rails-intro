require 'rails_helper'

describe Movie do
    describe '.find_similar_movies' do
        let!(:movie1) { FactoryBot.create(:movie, title: 'Star Wars IV', director: 'George Lucas') }
        let!(:movie2) { FactoryBot.create(:movie, title: 'Star Wars V', director: 'George Lucas') }
        let!(:movie3) { FactoryBot.create(:movie, title: '???', director: '') }
        
        context 'director exists' do
            it 'finds similar movies' do
                expect(Movie.similar_movies(movie1.title)).to eql(["Star Wars IV", "Star Wars V"])
            end
        end
        context 'director does not exist' do
            it 'follows sad path' do
                expect(Movie.similar_movies(movie3.title)).to eql(nil)
            end
        end
    end
end
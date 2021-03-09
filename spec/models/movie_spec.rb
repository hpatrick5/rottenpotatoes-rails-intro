require 'rails_helper'

describe Movie do
    let!(:movie1) { FactoryBot.create(:movie, title: 'Jaws', director: 'Steven Spielberg') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'E.T.', director: 'Steven Spielberg') }
    let!(:movie3) { FactoryBot.create(:movie, title: 'Star Wars IV', director: 'George Lucas') }
    let!(:movie4) { FactoryBot.create(:movie, title: 'I do not have a director, I am the sad path')}
    
    describe 'find with same director' do
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
end
require 'rails_helper'

describe MoviesController do
    describe 'finding similar movies' do
        it 'should call the model method that finds the similar movies' do
            Movie.should_receive(:find_similar).with('Test title')
            get :similar, {title: 'Test title'}
        end
        it 'should display all the movies with the same director' do
            movies = ['Star Wars IV', 'Star Wars V']
            Movie.stub(:find_similar).with('Star Wars IV').and_return(movies)
            get :similar, {title: 'Star Wars IV'}
            expect(assigns(:find_similar)).to eq(movies)
        end
        it 'should return to index and display a warning if movie has no director info' do
            Movie.stub(:find_similar).with('Movie with no director info').and_return(nil)
            get :similar, {title: 'Movie with no director info'}
            expect(assigns(:find_similar)).to eq(nil)
            expect(response).to redirect_to('/movies')
        end
    end
end
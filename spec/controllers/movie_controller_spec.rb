require 'rails_helper'

describe MoviesController do
    describe 'similar' do
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
    
    describe 'show' do
        let!(:movie1) { FactoryBot.create(:movie) }
        it 'should find the movie' do
            get :show, id: movie1.id
            expect(assigns(:movie)).to eq(movie1)
        end
        it 'should render show template' do
            get :show, id: movie1.id
            expect(response).to render_template('show')
        end
    end
    
    describe 'index' do
        it 'should render index template' do
            get :index
            expect(response).to render_template('index')
        end
        
        it 'sets ratings_to_show when provided ratings' do
            get :index, ratings: { 'G' => 1,  'PG' => 1 }
            expect(assigns(:ratings_to_show)).to eq(['G', 'PG'])
        end
        
        it 'sets sort to provided value' do
            get :index, { sort: 'sort' }
            expect(assigns(:sort)).to eq('sort')
        end
        
        it 'should assign title_header bg-warning when passed title, not release_date_header' do
            get :index, { sort: 'title' }
            expect(assigns(:title_header)).to eq('bg-warning')
            expect(assigns(:release_date_header)).to eq('hilite')
        end
        it 'should assign release_date_title bg-warning when passed release_date, not title_header' do
            get :index, { sort: 'release_date' }
            expect(assigns(:release_date_header)).to eq('bg-warning')
            expect(assigns(:title_header)).to eq('hilite')
        end
    end
    
    describe 'new' do
        it 'should render new view' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'create' do
        it 'creates a movie' do
            expect{post :create, movie: FactoryBot.attributes_for(:movie)}.to change(Movie, :count).by(1)
        end
        it 'redirects to index after create' do
            post :create, movie: FactoryBot.attributes_for(:movie)
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'edit' do
        let!(:movie1) { FactoryBot.create(:movie) }
        it 'should find movie to edit' do
            get :edit, id: movie1.id
            expect(assigns(:movie)).to eq(movie1)
        end
        it 'renders the edit template' do
            get :edit, id: movie1.id
            expect(response).to render_template('edit')
        end
    end
    
    describe 'update' do
        let!(:movie1) { FactoryBot.create(:movie) }
        it 'updates an existing movie' do
            put :update, id: movie1.id, movie: FactoryBot.attributes_for(:movie, title: 'New title')
            movie1.reload
            expect(movie1.title).to eq('New title')
        end
        it "redirects to updated movie's page" do
            put :update, id: movie1.id, movie: FactoryBot.attributes_for(:movie, title: 'New title')
            expect(response).to redirect_to(movie_path(movie1))
        end
    end
    
    describe 'destroy' do
        let!(:movie1) { FactoryBot.create(:movie) }
        it 'destroys a movie' do
            expect {delete :destroy, id: movie1.id}.to change(Movie, :count).by(-1)
        end
        it 'redirects to index after destroy' do
            delete :destroy, id: movie1.id
            expect(response).to redirect_to(movies_path)
        end
    end
end
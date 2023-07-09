require 'rails_helper'

RSpec.describe 'User Show Page' do
  before(:each) do
    user_test_data
    movie_detailsj2 = File.read('spec/fixtures/movie_details_jaws2.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/579?api_key=#{ENV['TMDB-KEY']}&append_to_response=credits,reviews,images")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.9'
        }
      )
      .to_return(status: 200, body: movie_detailsj2, headers: {})

      movie_detailsj2 = File.read('spec/fixtures/movie_details_jaws2.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/4?api_key=#{ENV['TMDB-KEY']}&append_to_response=credits,reviews,images").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.9'
           }).
         to_return(status: 200, body: movie_detailsj2, headers: {})
      
        movie_detailsj2 = File.read('spec/fixtures/movie_details_jaws2.json')
        stub_request(:get, "https://image.tmdb.org/t/p/w300/cN3ijEwsn4kBaRuHfcJpAQJbeWe.jpg.jpg?api_key=ee56bd2e560a84f6136dd019214eb695").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.9'
          }).
        to_return(status: 200, body: movie_detailsj2, headers: {})
    visit "/users/#{@user1.id}"
  end

  describe 'displays attributes' do
    it 'displays name and email' do
      expect(page).to have_content("Email: #{@user1.email}")
    end
  end

  describe 'US6 Dashboard (Show) Page' do
    it "I see user's name's Dashboard at the top of the page and a button to Discover Movies* " do
      expect(page).to have_content("#{@user1.name}'s Dashboard")
    end

    it "US7 I go to a user dashboard, and click 'Discover Movies button, I am redirected to a discover page '/users/:id/discover" do
      click_button('Discover Movies')
      expect(current_path).to eq("/users/#{@user1.id}/discover")
    end
  end

  describe 'viewing parties' do
    it 'A section that lists viewing parties hosted by user' do
      within('#viewing_parties_hosting') do
        expect(page).to have_content("#{@viewing_party1.movie_title}- Viewing Party")
        expect(page).to have_content("#{@viewing_party2.movie_title}- Viewing Party")
        expect(page).to have_content("#{@viewing_party3.movie_title}- Viewing Party")
        expect(page).to_not have_content("#{@viewing_party5.movie_title}- Viewing Party")
      end
    end

    it 'A section that lists viewing parties user is invited to' do
      within('#viewing_party_invitations') do
        save_and_open_page
        expect(page).to have_content("#{@viewing_party4.movie_title}- Viewing Party")
        expect(page).to have_content("#{@viewing_party5.movie_title}- Viewing Party")
        expect(page).to_not have_content("#{@viewing_party3.movie_title}- Viewing Party")
      end
    end
  end

  describe 'link to movie show page' do
    xit 'links to a movie show page in title of each movie' do
      click_link 'Jaws 2'

      expect(current_path).to eq('/movies/')
    end
  end
end

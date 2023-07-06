require "rails_helper" 

RSpec.describe "User Show Page" do 
  before(:each) do 
    @user1 = User.create!(name: "Maggie", email: "maggie@gmail.com")
    @viewing_party1 = ViewingParty.create!(day: "2023-07-01", start_time: "04:00 PM", movie_id: 1, duration: "120 minutes", movie_title: "Speed")
    @viewing_party2 = ViewingParty.create!(day: "2023-07-02", start_time: "05:00 PM", movie_id: 2, duration: "125 minutes", movie_title: "Spirited Away")
    @viewing_party3 = ViewingParty.create!(day: "2023-07-03", start_time: "04:30 PM", movie_id: 3, duration: "130 minutes", movie_title: "Up")

    @viewing_party4 = ViewingParty.create!(day: "2023-07-05", start_time: "06:00 PM", movie_id: 4, duration: "140 minutes", movie_title: "Wolfie finds a bone!")
    @viewing_party5 = ViewingParty.create!(day: "2023-07-08", start_time: "06:45 PM", movie_id: 5, duration: "144 minutes", movie_title: "Jaws")
    
    @userparty1 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party1.id, host: true)
    @userparty2 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party2.id, host: true)
    @userparty3 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party3.id, host: true)
    
    @userparty4 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party4.id, host: false)
    @userparty5 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party5.id, host: false)

    visit "/users/#{@user1.id}"
  end
  
  describe "displays attributes" do 
    it "displays name and email" do 
      expect(page).to have_content("Email: #{@user1.email}")
    end
  end
  
  describe "US6 Dashboard (Show) Page" do
    it "I see user's name's Dashboard at the top of the page and a button to Discover Movies* " do
      expect(page).to have_content("#{@user1.name}'s Dashboard")
    end
    
    it "US7 I go to a user dashbaord, and click 'Discover Movies button, I am redirected to a discover page '/users/:id/discover" do
      click_button("Discover Movies")
      expect(current_path).to eq("/users/#{@user1.id}/discover")
    end
  end

  describe "viewing parties" do 
    it "A section that lists viewing parties hosted by user" do
      within("#viewing_parties_hosting") do
        expect(page).to have_content("#{@viewing_party1.movie_title} Viewing Party")
        expect(page).to have_content("#{@viewing_party2.movie_title} Viewing Party")
        expect(page).to have_content("#{@viewing_party3.movie_title} Viewing Party")
      end
    end

    it "A section that lists viewing parties user is invited to" do
      within("#viewing_party_invitations") do
        # expect(page).to have_content("#{@viewing_party1.movie_title} Viewing Party")
        # expect(page).to have_content("#{@viewing_party2.movie_title} Viewing Party")
        # expect(page).to have_content("#{@viewing_party3.movie_title} Viewing Party")
      end
    end
  end
end
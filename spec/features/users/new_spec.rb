require "rails_helper" 

RSpec.describe "New User Form", type: :feature do 
  before(:each) do 
    visit "/register" 
  end
  describe "create a new user" do 
    it "using valid data" do 
      save_and_open_page
      fill_in "Name", with: "Wolfie"
      fill_in "Email", with: "wolfie@gmail.com"
      click_button "Create User" 

      expect(current_path).to eq("/users/#{User.all.last.id}")
      expect(page).to have_content("Wolfie")
      expect(page).to have_content("wolfie@gmail.com")
      expect(page).to have_content("User successfully registered.")
    end
  end
end
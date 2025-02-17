require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = User.create!(name: 'Maggie', email: 'maggie@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Max', email: 'max@gmail.com', password: 'woof', password_confirmation: 'woof')
    @viewing_party1 = ViewingParty.create!(day: '2023-07-01', start_time: '04:00 PM', movie_id: 1,
                                           duration: 120, movie_title: 'Speed')
    @viewing_party2 = ViewingParty.create!(day: '2023-07-02', start_time: '05:00 PM', movie_id: 2,
                                           duration: 125, movie_title: 'Spirited Away')
    @viewing_party3 = ViewingParty.create!(day: '2023-07-03', start_time: '04:30 PM', movie_id: 3,
                                           duration: 130, movie_title: 'Up')

    @viewing_party4 = ViewingParty.create!(day: '2023-07-05', start_time: '06:00 PM', movie_id: 4,
                                           duration: 140, movie_title: 'Wolfie finds a bone!')
    @viewing_party5 = ViewingParty.create!(day: '2023-07-08', start_time: '06:45 PM', movie_id: 5,
                                           duration: 144, movie_title: 'Jaws')

    @userparty1 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party1.id, host: true)
    @userparty2 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party2.id, host: true)
    @userparty3 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party3.id, host: true)

    @userparty4 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party4.id, host: false)
    @userparty5 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party5.id, host: false)
    @userparty6 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party5.id, host: false)
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    # it {should validate_presence_of(:password)}

    # it { should validate_presence_of(:password_confirmation)} 

    it { should validate_presence_of(:password_digest)} 
    # -- Remember, bcrypt will check out passwords, and store it as `password_digest`
    it { should have_secure_password}
    it "encrypts passwords with password_digest so they're not viewable in text form" do
      expect(@user2).to_not have_attribute(:password)
      expect(@user2.password_digest).to_not eq('woof')
    end
  end

  describe 'associatons' do
    it { should have_many(:user_viewing_parties) }
    it { should have_many(:viewing_parties).through(:user_viewing_parties) }
    it { should validate_presence_of(:email) }
  end

  describe 'instance method' do
    it 'parties_hosting' do
      expect(@user1.parties_hosting).to eq([@viewing_party1, @viewing_party2, @viewing_party3])
      expect(@user2.parties_hosting).to eq([])
      expect(@user1.parties_hosting).to_not include([@viewing_party4, @viewing_party5])
    end

    it 'parties_invited' do
      expect(@user1.parties_invited).to eq([@viewing_party4, @viewing_party5])
      expect(@user2.parties_invited).to eq([@viewing_party5])
      expect(@user1.parties_invited).to_not include([@viewing_party1, @viewing_party2, @viewing_party3])
    end
  end
end

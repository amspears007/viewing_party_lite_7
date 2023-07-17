# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,  presence: true
  validates :email,uniqueness: true, presence: true
  validates_presence_of :password
  # has_secure_password
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties



  def parties_hosting
    viewing_parties.where('user_viewing_parties.host = true')
  end

  def parties_invited
    viewing_parties.where('user_viewing_parties.host = false')
  end
end

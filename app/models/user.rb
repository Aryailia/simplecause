class User < ApplicationRecord
	has_many :following
	has_many :followers 
	
  include Clearance::User


  has_many :authentications, dependent: :destroy

    def self.create_with_auth_and_hash(authentication, auth_hash)
	      user = self.create!(
	        first_name: auth_hash["extra"]["raw_info"]["first_name"],
	        last_name: auth_hash["extra"]["raw_info"]["last_name"],
	    	email: auth_hash["extra"]["raw_info"]["email"],

		    #Just putting a random password to fill the column in the database because they're signing in with Facebook 
		    password: SecureRandom.hex(6)
	      )
	      user.authentications << authentication
	      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end


end

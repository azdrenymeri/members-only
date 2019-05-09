class User < ApplicationRecord
    
    has_many :posts
    
    before_save :downcase_email
    
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    # validations
    validates :name,presence: true,length:{minimum:2,maximum:30}
    validates :email,presence: true,length:{maximum: 255},format: {with:EMAIL_REGEX},
    uniqueness:{case_sensitive: false}
    has_secure_password
    validates :password , presence: true , length: {minimum:6,maximum:50}
    
    before_create{generate_token(:auth_token)}


    def self.find_by_auth_token(cookie)
       user =  User.where(:auth_token => cookie).first
        user 
    end

    def generate_token(column)
        begin 
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
    
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    private

    def downcase_email
        email.downcase!
    end
end

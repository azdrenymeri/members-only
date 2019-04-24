class User < ApplicationRecord
    attr_accessor :remember_token

    has_many :posts
    
    before_save :downcase_email
    
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    # validations
    validates :name,presence: true,length:{minimum:2,maximum:30},uniqueness:{case_sensitive:false}
    validates :email,presence: true,length:{maximum: 255},format: {with:EMAIL_REGEX},
    uniqueness:{case_sensitive: false}
    has_secure_password
    validates :password , presence: true , length: {minimum:6,maximum:50}
    
    def remember
        @remember_token = User.new_token
        update_attribute(:remember_digest,User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest,nil)
    end

    def User.digest(token)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(token, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end



    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    private

    def downcase_email
        email.downcase!
    end
end

class User < ActiveRecord::Base
    has_secure_password
    has_many :pets

    
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
end 
class Session < ApplicationRecord
    validates :email, presence: true 
end

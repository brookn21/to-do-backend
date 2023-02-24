class User < ApplicationRecord

    has_secure_password

    has_many :activities

    validates :email, presence: true, uniqueness: true, format: { with:
    URI::MailTo::EMAIL_REGEXP }

    PASSWORD_REQUIREMENTS = /\A
        (?=.{8,})
        (?=.*\d)
        (?=.*[a-z])
        (?=.*[A-Z])
        (?=.*[[:^alnum:]])
    /x
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS
    validates :username, presence: true, uniqueness: true
end

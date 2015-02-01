class Employer < User
    has_many :gigs
    has_many :workers ,through: :gigs

end
class Worker < User
  has_many :gigs
  has_many :employers ,through: :gigs
end
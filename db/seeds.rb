# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.where(:username => 'demo*').destroy_all
demoworker = Worker.find_or_create_by_email(username:  'demoworker',email:  'demoworker@appmunki.com',password: 'demoworker1',password_confirmation: 'demoworker1')
demoemployer = Employer.find_or_create_by_email(username:  'demoemployer',email:  'demoemployer@appmunki.com',password: 'demoemployer1',password_confirmation: 'demoemployer1')
if !demoemployer.save||!demoworker.save
  puts 'demo already created'
else
  puts 'demo created'
end

10.times() do
  5.times() do
    gig = Gig.create(total_price: 0, title: 'Dog Walking Job',description: 'I need someone to walk the dog while I am at work. You should be good with animals.',latitude: 37.019448, longitude: -76.360693,status: 'pending')
    worker = Worker.create(username:  SecureRandom.hex(13),email:  SecureRandom.hex(13)+'@appmunki.com',password: 'demoworker1',password_confirmation: 'demoworker1')

    gig.save

    worker.gigs<<gig
    demoemployer.gigs<<gig

    worker.save
  end
  5.times() do
    gig = Gig.create(total_price: 0, title: 'Help me Job',description: 'I need someone to walk the dog while I am at work. You should be good with animals.',latitude: 37.019448, longitude: -76.360693,status: 'pending')
    employer = Employer.create(username:  SecureRandom.hex(13),email:  SecureRandom.hex(13)+'@appmunki.com',password: 'demoemployer1',password_confirmation: 'demoemployer1')

    gig.save

    employer.gigs<<gig
    demoworker.gigs<<gig

    employer.save
  end
end

gig = Gig.create(total_price: 0, title: 'Dog Walking Job',description: 'I need someone to walk the dog while I am at work. You should be good with animals.',latitude: 37.019448, longitude: -76.360693,status: 'pending')
gig.save!

demoworker.gigs<<gig
demoemployer.gigs<<gig

case Rails.env
when "development"
  AdminUser.where(:email => "admin@appmunki.com").destroy_all
  AdminUser.create(email: 'admin@appmunki.com', password:'password')
  puts 'admin created'
when "production"

end

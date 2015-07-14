import 'factory_girl'

random_image_url = 'http://lorempixel.com/250/250/abstract'

puts 'Creating user...'
user = User.create email: 'test@test.com', password: '12345678'
john = FactoryGirl.create :person, user: user

open(Faker::Avatar.image(john.name.parameterize, '250x250'), 'rb') do |file|
  john.image = file
end

john.save
print '.'

puts
puts 'Creating people...'
40.times do
  p = FactoryGirl.create :person

  open(Faker::Avatar.image(p.name.parameterize, '250x250'), 'rb') do |file|
    p.image = file
  end

  p.save
  print '.'
end

puts
puts 'Creating clients...'
10.times do
  c = FactoryGirl.create :client

  open(Faker::Avatar.image(c.name.parameterize, '250x250'), 'rb') do |file|
    c.image = file
  end

  c.save
  print '.'
end

puts
puts 'Creating technologies...'
15.times do
  t = FactoryGirl.create :technology

  open(Faker::Avatar.image(t.name.parameterize, '250x250'), 'rb') do |file|
    t.image = file
  end

  t.save
  print '.'
end

# Create projects
30.times do
  p = FactoryGirl.create :project

  open(random_image_url, 'rb') do |file|
    p.image = file
  end

  p.client = Client.all.sample
  p.technologies = Technology.all.sample(4)
  Person.all.sample(5).each do |person|
    period_start = Date.today - (10..36).to_a.sample.months
    period_end = period_start + (1..10).to_a.sample.months

    p.members.create(person: person,
                     period_start: period_start,
                     period_end: period_end,
                     function: 'Dev')
  end

  p.save
  print '.'
end

puts
puts 'Done!'

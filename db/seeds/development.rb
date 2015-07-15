import 'factory_girl'

random_image_url = 'http://lorempixel.com/250/250/abstract'

puts 'Creating user...'
user = User.create email: 'test@test.com', password: '12345678'
john = FactoryGirl.create :person, user: user

open(random_image_url, 'rb') do |file|
  john.image = file
end

john.save
print '.'

puts
puts 'Creating people...'
40.times do
  p = FactoryGirl.create :person

  open(random_image_url, 'rb') do |file|
    p.image = file
  end

  p.save
  print '.'
end

puts
puts 'Creating clients...'
10.times do
  c = FactoryGirl.create :client

  open(random_image_url, 'rb') do |file|
    c.image = file
  end

  c.save
  print '.'
end

puts
puts 'Creating technologies...'
15.times do
  t = FactoryGirl.create :technology

  open(random_image_url, 'rb') do |file|
    t.image = file
  end

  t.save

  Person.all.sample(5).each do |person|
    skill_rating = (1..6).to_a.sample
    person.technologies.create(person: person,
                               skill_rating: skill_rating,
                               technology: t)
  end
  print '.'
end

puts
puts 'Creating roles...'

['Developer', 'Quality analyst', 'Tech Lead', 'Business analyst', 'Project Manager'].each do |role_name|
  FactoryGirl.create :role, name: role_name
end

puts
puts 'Creating projects...'
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
    role = Role.all.sample

    p.members.create(person: person,
                     period_start: period_start,
                     period_end: period_end,
                     role: role)
  end

  p.save
  print '.'
end

puts
puts 'Creating social interaction...'
300.times do
  model = [Project, Technology, Person].sample

  owner_instance = model.all.sample
  person = Person.all.sample

  owner_instance.activities.create(item: FactoryGirl.create(:post), user: person.user)
  print '.'
end


puts
puts 'Done!'

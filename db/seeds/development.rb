import 'factory_girl'

random_image_url = 'http://lorempixel.com/250/250/abstract'

puts
puts 'Creating administrator permission role...'
permission_role_administrator = FactoryGirl.create(:permission_role, :administrator)

puts
puts 'Creating administrator permission role acls...'
permission_acls_administrator = {
  dashboard: [
    :index
  ],
  activity: [
    :create
  ],
  client: [
    :index, :cards, :show, :card, :new, :edit, :create, :update, :destroy, :unfollow, :follow, :unlike, :like
  ],
  dashboard: [
    :index
  ],
  person: [
    :index, :cards, :show, :card, :new, :edit, :create, :update, :destroy, :unfollow, :follow, :unlike, :like
  ],
  post: [
    :new, :create
  ],
  project: [
    :index, :cards, :show, :card, :new, :edit, :create, :update, :destroy, :unfollow, :follow, :unlike, :like
  ],
  technology: [
    :index, :cards, :show, :card, :new, :edit, :create, :update, :destroy, :unfollow, :follow, :unlike, :like
  ]
}

permission_acls_administrator.each do|model, actions|
  puts "Inserting acls to #{model.to_s}:"
  actions.each do |action|
    puts "- #{action.to_s} \n"
    FactoryGirl.create :permission_acl, model: model.to_s, action: action.to_s, permission_role_id: permission_role_administrator.id
  end
end

puts
puts 'Creating user permission role...'
permission_role_user = FactoryGirl.create(:permission_role, :user, default: true)

puts
puts 'Creating user permission role acls...'
permission_acls_user = {
  dashboard: [
    :index
  ],
  activity: [
    :create
  ],
  client: [
    :index, :cards, :show, :card, :unfollow, :follow, :unlike, :like
  ],
  dashboard: [
    :index
  ],
  person: [
    :index, :cards, :show, :card, :unfollow, :follow, :unlike, :like
  ],
  post: [
    :new, :create
  ],
  project: [
    :index, :cards, :show, :card, :unfollow, :follow, :unlike, :like
  ],
  technology: [
    :index, :cards, :show, :card, :unfollow, :follow, :unlike, :like
  ]
}

permission_acls_user.each do|model, actions|
  puts "Inserting acls to #{model.to_s}:"
  actions.each do |action|
    puts "- #{action.to_s} \n"
    FactoryGirl.create :permission_acl, model: model.to_s, action: action.to_s, permission_role_id: permission_role_user.id
  end
end

puts
puts 'Creating user...'
user = User.create email: 'test@test.com', password: '12345678'
john = FactoryGirl.create :person, user: user

open(random_image_url, 'rb') do |file|
  john.image = file
end

john.save

puts
puts 'Assigning administrator permission role to test@test.com...'
administrator = User.find_by(email: 'test@test.com')
administrator.permission_roles << permission_role_administrator
administrator.save

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

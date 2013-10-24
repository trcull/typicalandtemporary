# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CustomerCohortScheme.find_or_initialize_by(:name=>'year-month').save!

me = User.where(:email=>'trcull@pollen.io').first
if me.nil?
  me = User.new
  me.email = 'trcull@pollen.io'
  me.password = 'foobar1234'
  me.save!
end

['Pollen','Lolitagirl','Rafter','Slideshop'].each do |name|
  o = Organization.where(:name=>name).first
  if o.nil?
    o = Organization.new
    o.name = name
    o.admin_user_id = me.id
    o.save!
  end
  if me.organizations.select {|o2| o2.id == o.id}.first.nil?
    me.organizations << o 
    me.save!
  end
end


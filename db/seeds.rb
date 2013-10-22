# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.connection.execute "insert into customer_cohort_schemes (name) values ('year-month');"

me = User.where(:email=>'trcull@pollen.io').first
if me.nil?
  me = User.new
  me.email = 'trcull@pollen.io'
  me.password = 'foobar1234'
  me.save!
end

['Pollen','Lolitagirl','Rafter','Slideshop'].each do |name|
  o = Organization.where(:name=>name)
  if o.nil?
    o = Organization.new
    o.name = name
    o.admin_user_id = me.id
    o.save!
  end
end


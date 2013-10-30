# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

me = User.where(:email=>'trcull@pollen.io').first
if me.nil?
  me = User.new
  me.email = 'trcull@pollen.io'
  me.password = 'foobar1234'
  me.save!
end


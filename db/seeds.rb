# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email: 'admin@ticketerz.com')
  User.create!(email: 'admin@ticketerz.com', password: 'password', admin: true)
end

seed_projects = ['Sublime 3', 'Atom', 'vim']

seed_projects.each do |name|
  unless Project.exists?(name: name)
    Project.create!(name: name, description: "A sample description about #{name}")
  end
end

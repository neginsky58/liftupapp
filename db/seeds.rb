# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin = User.create(:email => 'admin@gmail.com', :name =>'Admin', :admin => 1)
#test_user = User.create(:email => 'test@gmail.com', :name =>'Test User', :admin => 1)

cat1 = Category.create(:name => 'test category1')
cat2 = Category.create(:name => 'test category2')
cat3 = Category.create(:name => 'test category3')
cat4 = Category.create(:name => 'test category4')

loc1 = Projectlocation.create(:location => 'New York')
loc2 = Projectlocation.create(:location => 'KL')
loc3 = Projectlocation.create(:location => 'London')

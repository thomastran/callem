namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    users = User.all.limit(6)
    50.times do
      users.each { |user| FactoryGirl.create(:contact, :user => user) }
    end
  end
end

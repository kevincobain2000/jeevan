namespace :delete do
  desc 'Delete records older than 1 day'
  task :old_visitors => :environment do
    __old_visitors = Visitor.where('created_at < ?', Time.zone.now.beginning_of_day)
    puts "#{Time.zone.now.beginning_of_day},#{__old_visitors.count}"
    __old_visitors.destroy_all
  end
end
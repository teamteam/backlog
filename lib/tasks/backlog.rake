namespace :backlog do
  desc "Archive completed backlog items"
  task :archive => :environment do
    BacklogItem.where(:completed => true, :archived => false).each do |backlog_item|
      backlog_item.update_attribute :archived, true
    end
  end
end

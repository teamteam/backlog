namespace :backlog do
  desc "Archive completed backlog items"
  task :archive => :environment do
    BacklogItem.where(:archived => false).each do |backlog_item|
      if backlog_item.tasks.remaining.empty?
        backlog_item.update_attribute :archived, true
      end
    end
  end
end

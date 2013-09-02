class BacklogMailer < ActionMailer::Base
  default from: "notifications@thebacklog.io"

  def new_item_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Backlog Item Added"
  end

  def delete_item_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Backlog Item Deleted"
  end

  def update_item_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Backlog Item Updated"
  end
end

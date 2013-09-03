class BacklogMailer < ActionMailer::Base
  default from: "notifications@thebacklog.io"

  def create_item_email item
    recipients = User.all.map { |user| user.email }
    @item = item
    mail to: recipients.join(','), subject: "Backlog Item Created"
  end

  def delete_item_email item
    recipients = User.all.map { |user| user.email }
    @item = item
    mail to: recipients.join(','), subject: "Backlog Item Deleted"
  end

  def update_item_email item
    recipients = User.all.map { |user| user.email }
    @item = item
    mail to: recipients.join(','), subject: "Backlog Item Updated"
  end
end

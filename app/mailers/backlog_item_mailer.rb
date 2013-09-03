class BacklogItemMailer < ActionMailer::Base
  include BacklogMailer

  default from: "notifications@thebacklog.io"

  def create_item_email item
    send_mail item, "Backlog Item Created"
  end

  def delete_item_email item
    send_mail item, "Backlog Item Deleted"
  end

  def update_item_email item
    send_mail item, "Backlog Item Updated"
  end

  def send_mail item, subject
    @item = item
    mail to: recipients, subject: subject
  end
end

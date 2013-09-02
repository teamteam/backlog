class BacklogMailer < ActionMailer::Base
  default from: "notifications@thebacklog.io"

  def create_item_email item
    recipients = User.all.map { |user| user.email }
    @item = item
    mail to: recipients.join(','), subject: "Backlog Item Created"
  end

  def delete_item_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Backlog Item Deleted"
  end

  def update_item_email item
    recipients = User.all.map { |user| user.email }
    @item = item
    mail to: recipients.join(','), subject: "Backlog Item Updated"
  end

  def create_task_email task
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: "Task Created"
  end

  def update_task_email task
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: "Task Updated"
  end

  def delete_task_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Task Deleted"
  end

  def complete_task_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Task Marked Complete"
  end

  def incomplete_task_email
    recipients = User.all.map { |user| user.email }
    mail to: recipients.join(','), subject: "Task Marked Incomplete"
  end
end

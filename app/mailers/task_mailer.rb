class TaskMailer < ActionMailer::Base
  default from: "notifications@thebacklog.io"

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

  def delete_task_email task
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: "Task Deleted"
  end

  def complete_task_email task
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: "Task Marked Complete"
  end

  def incomplete_task_email task
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: "Task Marked Incomplete"
  end
end

class TaskMailer < ActionMailer::Base
  default from: "notifications@thebacklog.io"

  def create_task_email task
    send_mail task, "Task Created"
  end

  def update_task_email task
    send_mail task, "Task Updated"
  end

  def delete_task_email task
    send_mail task, "Task Deleted"
  end

  def complete_task_email task
    send_mail task, "Task Marked Complete"
  end

  def incomplete_task_email task
    send_mail task, "Task Marked Incomplete"
  end

  def send_mail task, subject
    recipients = User.all.map { |user| user.email }
    @task = task
    mail to: recipients.join(','), subject: subject
  end
end

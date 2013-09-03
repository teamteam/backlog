module BacklogMailer
  def recipients
    emails = User.all.map { |user| user.email }
    emails.join ','
  end
end

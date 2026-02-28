# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/expert_contact
  def expert_contact
    ContactMailer.expert_contact
  end

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/admin_notification
  def admin_notification
    ContactMailer.admin_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/general_contact
  def general_contact
    ContactMailer.general_contact
  end
end

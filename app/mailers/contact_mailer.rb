class ContactMailer < ApplicationMailer
  default from: "noreply@beriembitcoin.sk"

  def expert_contact(submission)
    @submission = submission
    @expert = submission.expert

    mail(
      to: @expert.email,
      subject: "Nova sprava od #{@submission.sender_name}"
    )
  end

  def admin_notification(submission)
    @submission = submission

    mail(
      to: Rails.application.config.admin_email,
      subject: "Nova kontaktna sprava - #{@submission.sender_name}"
    )
  end

  def general_contact(submission)
    @submission = submission

    mail(
      to: Rails.application.config.admin_email,
      subject: "Vseobecna kontaktna sprava od #{@submission.sender_name}"
    )
  end
end

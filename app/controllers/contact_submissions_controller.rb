class ContactSubmissionsController < ApplicationController
  def create
    @contact_submission = ContactSubmission.new(contact_submission_params)

    if params[:expert_id].present?
      @expert = Expert.active.find(params[:expert_id])
      @contact_submission.expert = @expert
    end

    if @contact_submission.save
      ContactMailer.admin_notification(@contact_submission).deliver_later

      if @contact_submission.expert.present?
        ContactMailer.expert_contact(@contact_submission).deliver_later
        redirect_to expert_path(@contact_submission.expert), notice: t("contact.success")
      else
        ContactMailer.general_contact(@contact_submission).deliver_later
        redirect_to root_path, notice: t("contact.success")
      end
    else
      if @expert
        render "experts/show", status: :unprocessable_entity
      else
        render "pages/kontakt", status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to experts_path, alert: t("common.not_found")
  end

  private

  def contact_submission_params
    params.require(:contact_submission).permit(:sender_name, :sender_email, :message)
  end
end

class Admin::ContactSubmissionsController < Admin::BaseController
  before_action :set_submission, only: [:show, :update]

  def index
    @submissions = ContactSubmission.recent
    @submissions = @submissions.by_status(params[:status]) if params[:status].present?
  end

  def show
    @submission.update(status: "read") if @submission.status == "new"
  end

  def update
    if @submission.update(submission_params)
      redirect_to admin_contact_submissions_path, notice: t("flash.submission_updated")
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_submission
    @submission = ContactSubmission.find(params[:id])
  end

  def submission_params
    params.require(:contact_submission).permit(:status)
  end
end

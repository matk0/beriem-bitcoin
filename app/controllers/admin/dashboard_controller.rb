class Admin::DashboardController < Admin::BaseController
  def index
    @experts_count = Expert.count
    @active_experts_count = Expert.active.count
    @submissions_count = ContactSubmission.count
    @new_submissions_count = ContactSubmission.where(status: "new").count
    @recent_submissions = ContactSubmission.recent.limit(5)
  end
end

class ExpertsController < ApplicationController
  def index
    @experts = Expert.active
    @experts = @experts.by_city(params[:city]) if params[:city].present?
    @cities = Expert.active.distinct.pluck(:city).sort
  end

  def show
    @expert = Expert.active.find(params[:id])
    @contact_submission = ContactSubmission.new
  rescue ActiveRecord::RecordNotFound
    redirect_to experts_path, alert: t("common.not_found")
  end
end

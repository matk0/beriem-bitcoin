class Admin::ExpertsController < Admin::BaseController
  before_action :set_expert, only: [:show, :edit, :update, :destroy]

  def index
    @experts = Expert.order(created_at: :desc)
  end

  def show
  end

  def new
    @expert = Expert.new
  end

  def create
    @expert = Expert.new(expert_params)

    if @expert.save
      redirect_to admin_experts_path, notice: t("flash.expert_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @expert.update(expert_params)
      redirect_to admin_experts_path, notice: t("flash.expert_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expert.destroy
    redirect_to admin_experts_path, notice: t("flash.expert_deleted")
  end

  private

  def set_expert
    @expert = Expert.find(params[:id])
  end

  def expert_params
    params.require(:expert).permit(:name, :city, :bio, :email, :photo, :active)
  end
end

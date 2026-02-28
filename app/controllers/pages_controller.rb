class PagesController < ApplicationController
  include ContentHelper

  def home
  end

  def bitcoin
    @content = render_content("bitcoin")
    redirect_to root_path, alert: t("common.not_found") unless @content
  end

  def faq
    @content = render_content("faq")
    redirect_to root_path, alert: t("common.not_found") unless @content
  end

  def navody
    @content = render_content("navody/index")
    @guides = navody_list
  end

  def navod
    @content = render_navod(params[:slug])
    redirect_to navody_path, alert: t("common.not_found") unless @content
  end
end

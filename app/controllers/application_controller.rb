class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :redirect_to_canonical_host

  private

  def redirect_to_canonical_host
    return unless Rails.env.production?

    canonical_host = "www.beriembitcoin.sk"
    return if request.host == canonical_host

    redirect_to "#{request.protocol}#{canonical_host}#{request.fullpath}", status: :moved_permanently, allow_other_host: true
  end
end

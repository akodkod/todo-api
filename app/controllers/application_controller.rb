class ApplicationController < ActionController::API
  # Includes
  include CanCan::ControllerAdditions

  # Exceptions Handlers
  rescue_from Exceptions::Authorization::Required, with: :render_unauthorized
  rescue_from Exceptions::Authorization::OnlyForGuests, with: :render_forbidden
  rescue_from CanCan::AccessDenied, with: :render_forbidden

  protected

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by(api_key: params[:api_key] || request.headers['X-API-KEY'])
  end

  def authentication_required!
    current_user or raise Exceptions::Authorization::Required
  end

  def non_authentication_required!
    !current_user or raise Exceptions::Authorization::OnlyForGuests
  end

  def render_errors(object, options = {})
    options[:status] ||= :bad_request

    render json: { errors: object.errors.details }, status: options[:status]
  end

  def render_unauthorized
    render json: { status: 401 }, status: :unauthorized
  end

  def render_forbidden
    render json: { status: 403 }, status: :forbidden
  end

  # Yes, I know about `load_and_authorize_resource`
  # But it's not compatible with my system of loading resources
  def authorize_resource!
    if action_name.to_sym == :index
      action = :read
    else
      action = action_name.to_sym
    end

    case action_name.to_sym
    when :index, :create
      object = controller_name.classify.constantize
    else
      object = send(controller_name.singularize)
    end

    authorize! action, object
  end
end

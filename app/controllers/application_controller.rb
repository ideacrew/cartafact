class ApplicationController < ActionController::API
  # before_action :authenticate

  private

  def authenticate
    headers = request.headers
    if headers['Authorization'].present?
      begin
        token = headers['Authorization'].split(' ').last
        JWT.decode(token, jwt_secret_key)
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        render json: {status: "failure", errors: ['Expired token']}
        return
      rescue JWT::DecodeError, JWT::VerificationError => e
        render json: {status: "failure", errors: ['Invalid token']}
        return
      rescue
        render json: {status: "failure", errors: ['Missing system key']}
        return
      end
    else
      render json: {status: "failure", errors: ['Missing Authorization Token']}
      return
    end
  end

  def jwt_secret_key
    Rails.application.credentials[params['authorized_identity']['system'].to_sym] if params['authorized_identity'] && params['authorized_identity']['system']
  end
end

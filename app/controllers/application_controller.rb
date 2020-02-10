class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    headers = request.headers
    if headers['Authorization'].present?
      begin
        token = headers['Authorization'].split(' ').last
        JWT.decode(token, jwt_secret_key)
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        render json: { message: 'Missing token' }, status: :expired_token
        return
      rescue JWT::DecodeError, JWT::VerificationError => e
        render json: { message: 'Missing token' }, status: :invalid_decode_token
        return
      rescue
        render json: { message: 'Missing token' }, status: :token_invalid
        return
      end
    else
      render json: { message: 'Missing token' }, status: :invalid_token
      return
    end
  end

  def jwt_secret_key
  end
end

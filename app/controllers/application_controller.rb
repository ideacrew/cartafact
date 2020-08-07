# frozen_string_literal: true

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
        render json: { status: "failure", errors: ['Expired token'] }
        nil
      rescue JWT::DecodeError, JWT::VerificationError => e
        render json: { status: "failure", errors: ['Invalid token'] }
        nil
      rescue StandardError
        render json: { status: "failure", errors: ['Missing system key'] }
        nil
      end
    else
      render json: { status: "failure", errors: ['Missing Authorization Token'] }
      nil
    end
  end

  def jwt_secret_key
    if params['authorized_identity'] && params['authorized_identity']['system']
      Rails.application.credentials[params['authorized_identity']['system'].to_sym]
    end
  end
end

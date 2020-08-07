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
      rescue JWT::ExpiredSignature, JWT::VerificationError
        render json: { status: "failure", errors: ['Expired token'] }
        nil
      rescue JWT::DecodeError, JWT::VerificationError
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
    extract_credentials_from_application_settings(params) if authorized_identity_specified?(params)
  end

  def extract_credentials_from_application_settings(params_hash)
    Rails.application.credentials[params_hash['authorized_identity']['system'].to_sym]
  end

  def authorized_identity_specified?(params_hash)
    params_hash['authorized_identity'] &&
      params_hash['authorized_identity']['system']
  end
end

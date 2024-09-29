module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = env['warden'].user

      if current_user.nil?
        logger.error("Unauthorized connection attempt from IP: #{request.remote_ip}")
        reject_unauthorized_connection
      end
    end
  end
end

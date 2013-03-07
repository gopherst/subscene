module Subscene
  class Response::RaiseError < Faraday::Response::Middleware
    ClientErrorStatuses = 400...600

    def on_complete(env)
      case env[:status]
      when 301, 302
        raise Subscene::SearchNotSupported, response_values(env)
      end
    end

    def response_values(env)
      {
        :status  => env[:status],
        :headers => env[:response_headers],
        :body    => env[:body]
      }
    end
  end
end

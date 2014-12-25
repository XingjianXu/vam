require 'jimson'

module Vam

  class VamServer

    class Handler
      extend Jimson::Handler
      def sum(a,b)
        a + b
      end
    end


    def initialize(host, port)
      @host = host
      @port = port
    end


    def start
      server = Jimson::Server.new(Handler.new, host: @host, port: @port, server: 'thin')
      server.start
    end


  end

end

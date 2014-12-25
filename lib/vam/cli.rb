require 'vam/constants'
require 'vam/dsl'
require 'vam/repo'
require 'vam/server'

module Vam
  class CLI

    def self.start(argv)
      Dir.mkdir VAMROOT unless File.directory? VAMROOT
      if argv.length > 0

        case argv[0]
          when 'install'
            install
          when 'scan'
            scan
          when '-v'
            print_version
          else
            print_version
        end

      elsif
        print_version
      end
    end


    def self.print_version
      puts "Vam: version #{VERSION}"
    end

    def self.install
      vamfile = File.join Dir.pwd, 'Vamfile'
      dsl = Dsl.evaluate vamfile

      dsl.vams.each do |vam|
        dest = File.join Dir.pwd, 'vendor', 'assets', 'components'
        vam.install dest
      end

    end


    def self.scan
      dir = Dir.getwd
      Repo.scan dir
    end

  end
end

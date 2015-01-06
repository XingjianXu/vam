require 'fileutils'
require 'colorize'
require 'open-uri'
require 'pp'

require 'vam/constants'
require 'vam/errors'

module Vam

  class Vam

    SNAPSHOT = 'SNAPSHOT'

    def initialize(name, dsl, options)
      @name = name
      @dsl = dsl

      @urls = []

      if options.include?(:version)
        @version = options[:version]
      else
        @version = @dsl.repo.latest_version @name
      end

      @files = @dsl.repo.files @name, @version

      tmproot = "#{VAMROOT}/#{@name}"
      @vroot = File.join tmproot, @version
      @vroot_tmp = File.join tmproot, ".tmp-#{@version}"

    end


    def install(dest)
      puts "===Install #{@name}===".colorize(:blue)
      if cached?
        puts 'Using cache...'
      else
        download
      end
      copy File.join(dest, @name)

    end


    def cached?
      Dir.exist? @vroot
    end


    def download
      FileUtils.mkdir_p @vroot_tmp

      @files.each do |file|
        dir = File.join @vroot_tmp, file[:dir]
        FileUtils.mkdir_p dir unless Dir.exist? dir
        df = File.join dir, file[:filename]

        open File.join(df), 'wb' do |s|
          puts "Download #{file[:url]}"
          s << open(file[:url]).read
        end
      end

      FileUtils.move @vroot_tmp, @vroot
    end


    def copy(dest)
      if Dir.exist? dest
        FileUtils.rm_r dest
      end

      FileUtils.mkdir_p dest

      FileUtils.cp_r "#{@vroot}/.", dest
    end


  end
end

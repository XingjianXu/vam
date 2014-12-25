require 'open-uri'

module Vam

  class Repo

    attr_accessor :repo_url

    def initialize
      @repo_url = ''
      @vendors = {}
    end


    def latest_version(name)
      @vendors[name].keys.sort[0]
    end


    def files(name, version)
      @vendors[name][version].collect do |e|
        {
            dir: File.dirname(e),
            filename: File.basename(e),
            url: File.join(repo_url, name, version, e)
        }
      end
    end


    def add(name, version, rpath)
      unless @vendors.include? name
        @vendors[name] = {}
      end

      unless @vendors[name].include? version
        @vendors[name][version] = []
      end

      if rpath.is_a? Array
        @vendors[name][version] = rpath
      else
        @vendors[name][version] << rpath
      end
    end


    def self.scan(dir)
      repo = Repo.new
      Dir.glob(File.join dir, '*').each do |s|
        name = File.basename(s)

        Dir.glob(File.join s, '*').each do |v|
          version = File.basename(v)
          files = Dir.glob(File.join v, '/**/*').collect { |e| e.slice!("#{v}/"); e }
          repo.add name, version, files
        end
      end

      Repo.dump dir, repo
    end


    def self.load(repo_url)
      repo = Marshal.load open(File.join(repo_url, 'repo'))
      repo.repo_url = repo_url
      repo
    end


    def self.dump(dir, repo)
      File.open(File.join(dir, 'repo'), 'w') {|f| f.write(Marshal.dump repo)}
    end

  end

end

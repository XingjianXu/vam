require 'vam/vam'

require 'jimson'


module Vam
  class Dsl

    attr_reader :vams, :repo

    def self.evaluate(vamfile)
      dsl = new()
      dsl.eval_vamfile(vamfile)
      return dsl
    end


    def initialize
      @vams = []
    end


    def eval_vamfile(vamfile, contents = nil)
      contents ||= File.read(vamfile)
      instance_eval(contents, vamfile.to_s, 1)
    end


    def vam(name, *args)
      options = args.last.is_a?(Hash) ? args.last.dup : {}

      if args.first.is_a?(String)
        options[:version] = args.first
      end

      vam = Vam.new name, self, options
      @vams << vam
    end


    def source(url)
      @source = url
      @repo = Repo.load url
    end

  end
end

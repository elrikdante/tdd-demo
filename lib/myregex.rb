require 'open3'
require 'pry'
module MyRegex

  class << self
    def build body
      Instance.new(body)
    end
  end

  class Instance

    def initialize(body)
      @body = body
    end

    def match? string
      @string = string
      run!
      @success
    end

    private
    def run!
      result,_ = Open3.capture2("./bin/myreggy", stdin_data: [@body,@string].join("\n"))
      result   = result.chomp.gsub(/"/m,'').split(',')
      @success = result.any? && result.first.length > 0
    end
  end

end

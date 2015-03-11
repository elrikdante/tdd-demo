require 'open3'
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
     run! string
    end

    private
    def run! string
      result,_ = Open3.capture2("./bin/myreggy", stdin_data: [@body,string].join("\n"))
      result   = result.chomp.gsub(/"/m,'').split(',')
      result.any? && result.first.length > 0
    end
  end

end

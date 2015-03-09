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
      @string = string
      run!
      @success
    end

    private
    def run!
      Open3.popen3("./bin/myreggy") do |input,output,_|
        input.sync = true
        output.sync = true
        input.puts @body
        input.puts @string
        input.close
        result = output.read.chomp.to_i
        @success = result == 1
      end
    end
  end
end

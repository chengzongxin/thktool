require 'json'

class TriggerEvent

    attr_accessor :fwk
    attr_accessor :commit

    def initialize(argv)
        data = argv.first
        json = JSON.parse(data)
        # p json
        msg = json['commits'].first['message']
        /【([a-zA-Z0-9]*)】/.match(msg)
        @fwk = $1
        @commit = json['after']
    end

    def validate_object
        p @fwk
        p @commit
        if @fwk.nil? || @commit.nil?
            p "no framework or commit founds"
            return nil
        end
        return @fwk,@commit
    end
end
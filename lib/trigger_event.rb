require 'json'

class TriggerEvent
    def initialize(argv)
        data = argv.first
        json = JSON.parse(data)
        # p json
        msg = json['commits'].first['message']
        /【([a-zA-Z0-9]*)】/.match(msg)
        @fwk = $1
        @commit = json['after']
    end

    def change_source_spec
        p @fwk
        p @commit
        if @fwk.nil? || @commit.nil?
            p "no framework or commit founds"
        end
    end
end
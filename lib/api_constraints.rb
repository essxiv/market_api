class ApiConstraints
    def initialize(options)
        @verison = options[:verison]
        @default = options[:default]
    end

    def matches?(req)
        @default || req.headers['Accept'].include?("application/vnd.marketplace.v#{@verison}")
    end
end
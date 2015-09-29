require 'spec_helper'

describe ApiConstraints do
    let(:api_constraints_v1) { ApiConstraints.new(verison: 1) }
    let(:api_constraints_v2) { ApiConstraints.new(verison: 2, default: true) }
    describe "matches?" do

        it "returns true when verison matches the 'Accept' header" do
            request = double(host: 'localhost:3000', headers: {"Accept" => "application/vnd.marketplace.v1"})
            api_constraints_v1.matches?(request).should be_true
        end

        it "returns the default verison when 'default' option is specified" do
            request = double(host: 'localhost:3000')
            api_constraints_v2.matches?(request).should be_true
        end
    end
end
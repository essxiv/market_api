require 'spec_helper'

describe Placement do
  #pending "add some examples to (or delete) #{__FILE__}"

  let(:placement) { FactoryGirl.build :placement }
  subject { placement }

  it { should respond_to :order_id }
  it { should respond_to :product_id }

  it { should belong_to :order }
  it { should belong_to :product }
end

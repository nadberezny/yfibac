require 'spec_helper'

describe Checkout::ApplyPricingRules do
  describe '#call' do
    it_behaves_like 'checkout scan'
  end
end
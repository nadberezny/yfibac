require 'spec_helper'

describe Checkout::Scan do
  describe '#call' do
    it_behaves_like 'checkout scan'
  end
end
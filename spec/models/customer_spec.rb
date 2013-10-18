require 'spec_helper'

describe Customer do
  it "doesn't explode" do
    create(:customer)
  end
end

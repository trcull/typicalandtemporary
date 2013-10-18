require 'spec_helper'

describe Order do
  it "doesn't explode" do
    create(:order)
  end
end

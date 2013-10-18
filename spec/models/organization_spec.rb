require 'spec_helper'

describe Organization do
  it "doesn't explode" do
    create(:organization)
  end
end
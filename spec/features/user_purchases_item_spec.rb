require 'rails_helper'

RSpec.feature 'user purchases item' do
  let!(:user) { create(:user) }

  context "from another users' listing" do
    it 'is successful' do
    end
  end

  context "from own users' listing" do
    it 'is successful' do
    end
  end
end

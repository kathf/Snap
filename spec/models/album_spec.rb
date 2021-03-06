require 'rails_helper'

RSpec.describe Album, type: :model do
  it { is_expected.to have_many(:photos) }
  it { is_expected.to validate_presence_of(:name) }
end

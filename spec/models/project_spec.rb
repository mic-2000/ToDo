require 'rails_helper'

RSpec.describe Project, :type => :model do

  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of(:name) }

  it "should set priority" do
    user = create(:user)
    project1 = create(:project, user: user)
    project2 = create(:project, user: user)
    expect(project1.priority).to eq(1)
    expect(project2.priority).to eq(2)
  end

end

require 'rails_helper'

RSpec.describe Task, :type => :model do
  it { should belong_to(:project) }
  it { should validate_presence_of(:name) }

  it "should set priority" do
    user = create(:user)
    project = create(:project, user: user)
    task1 = create(:task, project: project)
    task2 = create(:task, project: project)
    expect(task1.priority).to eq(1)
    expect(task2.priority).to eq(2)
  end
end

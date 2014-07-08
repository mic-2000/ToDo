require 'rails_helper'

describe "Comments", :type => :feature, js: true do
  before(:each) do
    @task = create(:task)
    @user= @task.project.user
  end

  describe "Add comment" do
    before(:each) do
      sign_in_js @user
    end

    it "should add comment" do
      within(".row.task") do
        click_link 'comment'
        fill_in 'comment[body]', :with => 'Comment 1'
        click_button 'Add'
      end
      expect(page).to have_text 'Comment 1'
      expect(@task.comments.where(body: 'Comment 1').size).to eq(1)
    end
  end

  it "should destroy comment" do
    @comment = create(:comment, task: @task)
    sign_in_js @user
    within(".row.task") do
      click_link 'comment'
      within(".row.comment") do
        click_link 'destroy'
      end
    end
    expect(page).to have_no_text @comment.body
    expect(@task.comments.where(body: @comment.body).size).to eq(0)
  end

end
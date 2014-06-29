require 'rails_helper'

describe "Tasks", :type => :feature, js: true do
  before(:each) do
    @user = create(:user)
    @project = create(:project, user: @user)
  end

  describe "Add task" do
    before(:each) do
      sign_in_js @user
    end

    it "should add task" do
      within(".row.add_task") do
        fill_in 'new_task', :with => 'Task 1'
        click_button 'Add Task'
      end
      expect(page).to have_text 'Task 1'
      expect(@project.tasks.where(name: 'Task 1').size).to eq(1)
    end

    it "should check presence validation" do
      within(".row.add_task") do
        fill_in 'new_task', :with => ''
        click_button 'Add Task'
      end
      expect(page).to have_no_selector('.row.task', visible: true)
    end
  end

  describe "Edit task" do
    before(:each) do
      @task = create(:task, project: @project)
      sign_in_js @user
    end

    it "should show edit form" do
      within(".row.task") do
        click_link 'edit'
      end
      expect(page).to have_selector('.edit_task', visible: true)
    end

    it "should change task name" do
      within(".row.task") do
        click_link 'edit'
        fill_in 'edit_name', :with => 'Change task'
        click_link 'save'
      end
      expect(page).to have_text 'Change task'
      expect(@project.tasks.where(name: 'Change task').size).to eq(1)
      expect(@project.tasks.where(name: @task.name).size).to eq(0)
    end

    it "deadline < Today should add style .deadline" do
      within(".row.task") do
        click_link 'edit'
        fill_in 'deadline', :with => Date.today - 2.days
        click_link 'save'
        expect(page).to have_css('.deadline')
        @task.reload
      end
    end

     it "if task done should add style .done" do
      within(".row.task") do
        check('done')
        expect(page).to have_css('.done')
        @task.reload
        expect(@task.done).to eq(true)
      end
    end
  end

  it "should destroy task" do
    @task = create(:task, project: @project)
    sign_in_js @user
    within(".row.task") do
      click_link 'destroy'
    end
    expect(page).to have_no_text @task.name
    expect(@project.tasks.where(name: @task.name).size).to eq(0)
  end

  it "sorting" do
    task1 = create(:task, project: @project)
    task2 = create(:task, project: @project)
    sign_in_js @user
    within(".sort_task") do
      task_drag = page.all('.row.task').last.find_by_id('sort')
      first_task = page.first('.row.task')
      task_drag.drag_to(first_task)
      expect(page.first('.row.task')).to have_text task2.name
    end
    @project.tasks.reload
    expect(@project.tasks.map(&:id)).to eq([task2.id, task1.id])
  end

end
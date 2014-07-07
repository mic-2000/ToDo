require 'rails_helper'

describe "Projects", :type => :feature, js: true do

  describe "Add project" do
    before(:each) do
      sign_in_js
    end
    it "should show add form" do
      click_button 'Add TODO List'
      expect(page).to have_selector('.row.pr_title input', visible: true)
    end

    it "should add project" do
      click_button 'Add TODO List'
      page.execute_script("$('.pr_title a').css('display','inline')")
      within(".row.pr_title") do
        fill_in 'new_pr', :with => 'Project 1'
        click_link 'save'
      end
      expect(page).to have_text 'Project 1'
      expect(Project.where(name: 'Project 1').size).to eq(1)
    end

    it "should check presence validation" do
      click_button 'Add TODO List'
      page.execute_script("$('.pr_title a').css('display','inline')")
      within(".row.pr_title") do
        fill_in 'new_pr', :with => ''
        click_link 'save'
        expect(page).to have_css('.error')
      end
    end
  end

  describe "Edit project" do
    before(:each) do
      @user = create(:user)
      @project = create(:project, user: @user)
      sign_in_js @user
    end

    it "should show edit form" do
      page.execute_script("$('.pr_title a').css('display','inline')")
      click_link 'edit'
      expect(page).to have_selector('.row.pr_title input', visible: true)
    end

    it "should change project name" do
      page.execute_script("$('.pr_title a').css('display','inline')")
      click_link 'edit'
      within(".row.pr_title") do
        fill_in 'new_pr', :with => 'Change project'
        click_link 'save'
      end
      expect(page).to have_text 'Change project'
      expect(Project.where(name: 'Change project').size).to eq(1)
      expect(Project.where(name: @project.name).size).to eq(0)
    end
  end

  it "should destroy project" do
    @user = create(:user)
    @project = create(:project, user: @user)
    sign_in_js @user
    page.execute_script("$('.pr_title a').css('display','inline')")
    click_link 'destroy'
    expect(page).to have_no_text @project.name
    expect(Project.where(name: @project.name).size).to eq(0)
  end

end
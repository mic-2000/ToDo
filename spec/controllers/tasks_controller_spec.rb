require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  before :each do
    user = create(:user)
    @project = create(:project, user: user)
    sign_in user
  end

  let(:valid_attributes) { attributes_for(:task) }

  let(:invalid_attributes) { {name: ''} }

  describe "GET index" do
    it "assigns all tasks as @tasks" do
      task = create(:task, project: @project)
      get :index, {project_id: @project.id, format: :json}
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, {:task => valid_attributes, project_id: @project.id, format: :json}
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {:task => valid_attributes, project_id: @project.id, format: :json}
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        post :create, {:task => invalid_attributes, project_id: @project.id, format: :json}
        expect(assigns(:task)).to be_a_new(Task)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { attributes_for(:task) }

      it "updates the requested task" do
        task = create(:task, project: @project)
        put :update, {:id => task.to_param, :task => new_attributes, project_id: @project.id, format: :json}
        task.reload
        expect(task.name).to eq(new_attributes[:name])
      end

      it "assigns the requested task as @task" do
        task = create(:task, project: @project)
        put :update, {:id => task.to_param, :task => valid_attributes, project_id: @project.id, format: :json}
        expect(assigns(:task)).to eq(task)
      end
    end

    describe "with invalid params" do
      it "assigns the task as @task" do
        task = create(:task, project: @project)
        put :update, {:id => task.to_param, :task => invalid_attributes, project_id: @project.id, format: :json}
        expect(assigns(:task)).to eq(task)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = create(:task, project: @project)
      expect {
        delete :destroy, {:id => task.to_param, project_id: @project.id, format: :json}
      }.to change(Task, :count).by(-1)
    end
  end

  describe "POST sort" do
    it "save sorted tasks" do
      20.times { create(:task, project: @project) }
      resort_id = @project.tasks.map(&:id).shuffle
      post :sort, {task: {priority: resort_id}, project_id: @project.id, format: :json}
      @project.tasks.reload
      expect(@project.tasks.map(&:id)).to eq(resort_id)
    end
  end

end

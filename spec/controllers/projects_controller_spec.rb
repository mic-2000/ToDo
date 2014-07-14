require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  let(:valid_attributes) { attributes_for(:project) }

  let(:invalid_attributes) { {name: ''} }

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = create(:project, user: @user)
      get :index, {}
      expect(assigns(:projects)).to eq([project])
    end

    it "assigns only own projects" do
      project = create(:project, user: @user)
      project1 = create(:project)
      get :index, {}
      expect(assigns(:projects)).to eq([project])
      expect(assigns(:projects)).not_to eq([project1])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => valid_attributes, format: :json}
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => valid_attributes, format: :json}
        expect(assigns(:project)).to be_a(Project)
        expect(assigns(:project)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        post :create, {:project => invalid_attributes, format: :json}
        expect(assigns(:project)).to be_a_new(Project)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {attributes_for(:project)}

      it "updates the requested project" do
        project = create(:project, user: @user)
        put :update, {:id => project.to_param, :project => new_attributes, format: :json}
        project.reload
        expect(project.name).to eq(new_attributes[:name])
      end

      it "assigns the requested project as @project" do
        project = create(:project, user: @user)
        put :update, {:id => project.to_param, :project => valid_attributes, format: :json}
        expect(assigns(:project)).to eq(project)
      end

      it "should not update someone else's project" do
        project = create(:project)
        put :update, {:id => project.to_param, :project => valid_attributes, format: :json}
        expect(assigns(:current_ability)).to_not be_able_to(:update, project)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = create(:project, user: @user)
        put :update, {:id => project.to_param, :project => invalid_attributes, format: :json}
        expect(assigns(:project)).to eq(project)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = create(:project, user: @user)
      expect {
        delete :destroy, {:id => project.to_param, format: :json}
      }.to change(Project, :count).by(-1)
    end

    it "should not destroy someone else's project" do
      project = create(:project)
      delete :destroy, {:id => project.to_param, format: :json}
      expect(assigns(:current_ability)).to_not be_able_to(:destroy, project)
    end
  end

end

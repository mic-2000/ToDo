require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  before :each do
    user = create(:user)
    @project = create(:project, user: user)
    @task = create(:task, project: @project)
    sign_in user
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      comment = create(:comment, task: @task)
      get :index, {task_id: @task.id, format: :json}
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {comment: {body: 'Text'}, task_id: @task.id, format: :json}
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {comment: {body: 'Text'}, task_id: @task.id, format: :json}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, {comment: {body: ''}, task_id: @task.id, format: :json}
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = create(:comment, task: @task)
      expect {
        delete :destroy, {:id => comment.to_param, task_id: @task.id, format: :json}
      }.to change(Comment, :count).by(-1)
    end

    it "should not destroy someone else's comment" do
      comment = create(:comment)
      delete :destroy, {:id => comment.to_param, task_id: comment.task.id, format: :json}
      expect(assigns(:current_ability)).to_not be_able_to(:destroy, comment)
    end
  end

end

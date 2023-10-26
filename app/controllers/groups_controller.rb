class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def show
    @user = current_user
    @group = Group.find(params[:id])
  end

  def index
    @user = current_user
    @groups = Group.all
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      @group.group_users.create(user: current_user)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end

class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :sign_in]

  def index
    @prototypes = Prototype.all
  end


  def new
    @prototypes = Prototype.new
  end

  def create
    @prototypes = Prototype.create(prototype_params)
    if @prototypes.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @prototypes.destroy
    redirect_to root_path
  end

  def edit
    unless current_user.id == @prototypes.user_id
      redirect_to root_path
    end
  end

  def show
    @prototypes = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototypes.comments.includes(:user)
  end

  def update
    @prototypes.update(prototype_params)
    if @prototypes.save
       redirect_to prototype_path
    else
      render :edit
    end
  end

private
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
end

def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
end

def set_prototype
  @prototypes = Prototype.find(params[:id])
end

def move_to_index
  unless user_signed_in?
    redirect_to new_user_session_path
  end
end
end
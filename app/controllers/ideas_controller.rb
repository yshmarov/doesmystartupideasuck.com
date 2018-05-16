class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @ideas = Idea.order("created_at DESC").all
  end

  def top
    @ideas = Idea.order(:cached_weighted_score => :desc)
    render 'index'
  end

  def upvote
    @idea.upvote_by current_user
    redirect_to ideas_path
    #redirect_to idea_path(@idea)
  end

  def downvote
    @idea.downvote_by current_user
    redirect_to ideas_path
    #redirect_to idea_path(@idea)
  end

  def show
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      redirect_to @idea, notice: 'Idea was successfully created.'
    else
      render :new
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'Idea was successfully updated.'
    else
      render :edit
      format.html { render :edit }
    end
  end

  def destroy
    @idea.destroy
      redirect_to ideas_url, notice: 'Idea was successfully destroyed.'
  end

  private
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:name, :description, :user_id)
    end
end

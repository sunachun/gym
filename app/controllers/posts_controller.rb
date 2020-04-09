class PostsController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order("created_at DESC")
  end
  
  def index1
    @posts = Post.where(trick_name: "男子　床").order("created_at DESC")
  end
  
  def index2
    @posts = Post.where(trick_name: "鞍馬").order("created_at DESC")
  end
  
  def index3
    @posts = Post.where(trick_name: "吊り輪").order("created_at DESC")
  end
  
  def index4
    @posts = Post.where(trick_name: "男子　跳馬").order("created_at DESC")
  end
  
  def index5
    @posts = Post.where(trick_name: "平行棒").order("created_at DESC")
  end
  
  def index6
    @posts = Post.where(trick_name: "鉄棒").order("created_at DESC")
  end
  
  def index7
    @posts = Post.where(trick_name: "女子　跳馬").order("created_at DESC")
  end
  
  def index8
    @posts = Post.where(trick_name: "段違い平行棒").order("created_at DESC")
  end
  
  def index9
    @posts = Post.where(trick_name: "平均台").order("created_at DESC")
  end
  
  def index10
    @posts = Post.where(trick_name: "女子　床").order("created_at DESC")
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @like_count = Like.where(post_id: @post.id).count
    @comments = @post.comments.includes(:user)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
      trick_name: params[:trick],
      #video: "#{params[:video].read}.mp4"
      )
      @post.save
      if params[:video]
      @post.video = "#{@post.id}.mp4"
      video = params[:video]
      File.binwrite("public/user_videos/#{@post.video}", video.read)
      end
      
    
      if @post.save
        flash[:notice] = "投稿を作成しました"
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.trick_id = params[:trick]
    
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end

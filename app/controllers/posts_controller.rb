class PostsController < ApplicationController

  before_action :authenticate_user!
  #新規投稿
  def new
    @post = Post.new
    @post.photos.build
  end

  #投稿処理
  def create
    @post = Post.new(post_params)

    #debug用
    #binding.pry

    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  # 投稿一覧表示
  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  end
  
  # 投稿詳細
  def show
    @post = Post.find_by(id: params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
    
end

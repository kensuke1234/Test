class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blogs,only:[:show, :edit, :update, :destroy]

  def index
    # @blogs = Blog.all
    @blogs = Blog.page(params[:page]).per(5)
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog.id)
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to edit_blog_path(@blog.id)
    end
  end

  def destroy
    if @blog.destroy
      redirect_to root_path
    end
  end

  private
  def set_blogs
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :price,:amount, :image, :image_cache_id,:description)
  end

end

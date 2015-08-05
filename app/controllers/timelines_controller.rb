class TimelinesController < ApplicationController


  
  def show
    @user = User.find(params[:user_id])
    @posts =  Post.all.where("posted_id = #{params[:user_id]}")
    @post = Post.new
  end 
end

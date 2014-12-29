class StaticPagesController < ApplicationController
  def home
  end

  def help
  	# render :text => "This is help page."
  	flash[:notice] = "You have been redirected."
  	redirect_to :action => 'home'
  end
end

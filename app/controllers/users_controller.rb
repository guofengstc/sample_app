class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: :destroy

	def index
		# @users=User.all
		# @users = User.paginate(page: params[:page])
		@users = User.page(params[:page])
	end
	def show
		# binding.pry
		@user=User.find(params[:id])
		@microposts = nil
		# @microposts = @user.microposts.paginate(page: params[:page])
		puts "============================"
	end
	def new
		@user=User.new
	end
	def create
		# binding.pry
		@user=User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end
	def edit
	  @user = User.find(params[:id])
	end

	def update
		# binding.pry
	  @user = User.find(params[:id])
	  if @user.update_attributes(params[:user])
	    # Handle a successful update.
	    flash[:success] = "Profile updated"
	    sign_in @user
	    redirect_to @user
	  else
	    render 'edit'
	  end
	end

	def destroy
	  User.find(params[:id]).destroy
	  flash[:success] = "User destroyed."
	  redirect_to users_url
	end

	private

	  def signed_in_user
	    # redirect_to signin_url, notice: "Please sign in." unless signed_in?
		  unless signed_in?
		    store_location
		    redirect_to signin_url, notice: "Please sign in."
		  end
	  end

	  def correct_user
	    @user = User.find(params[:id])
	    redirect_to(root_path) unless current_user?(@user)
	  end

	  def admin_user
	    redirect_to(root_path) unless current_user.admin?
	  end
	  public
	  def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    # @users = @user.followed_users.paginate(page: params[:page])
	    @users = @user.followed_users.page(params[:page])
	    render 'show_follow'
	  end

	  def followers
	    @title = "Followers"
	    @user = User.find(params[:id])
	    # @users = @user.followers.paginate(page: params[:page])
	    @users = @user.followers.page(params[:page])
	    render 'show_follow'
	  end

	  def follow_add
	  	
	  	@user = User.find(params[:user][:id])
	    current_user.followed_users << @user
	    # binding.pry
	    puts "======#{current_user.followed_users}"
	    current_user.save
	    @user.followers<<current_user
	    @user.save
	    #relationships.create!(followed_id: other_user.id)
	    puts "======#{current_user.followed_users}"
	    puts "======================================================"
	      redirect_to @user 

	  end

	  def follow_del
	  	binding.pry
	  	@user = User.find(params[:user][:id])
	  	# @user = User.find_by(id:params[:user][:id])
	    current_user.followed_users.delete(@user)
	    
	    puts "======#{current_user.followed_users}"
	    current_user.save
	    
	    # @user.followers.delete(User.find(current_user.id))
	    @user.save
	    #relationships.create!(followed_id: other_user.id)
	    puts "======#{current_user.followed_users}"
	    puts "======================================================"
		
		redirect_to @user 
	
	  end
end

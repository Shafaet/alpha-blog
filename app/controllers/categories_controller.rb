class CategoriesController < ApplicationController
	before_action :require_admin,except:[:index,:show]
	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def new
		@category = Category.new
		@user=User.create(username: "John", email: "john@example.com", password: "password", admin:true)
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success]= "Category created!"
			redirect_to categories_path
		else
			render 'new'
		end
	end
	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:success] = "Category name was successfully updated"
			redirect_to category_path(@category)
		else
			render 'edit'
		end
	end
	def show
		@category = Category.find(params[:id])
		@category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
   		if !logged_in? || (logged_in? and !current_user.admin?)
      			flash[:danger]="Only admins can create categories"
    	  		redirect_to categories_path
   		end
	end
 	
end

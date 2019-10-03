class KittensController < ApplicationController
	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.html
			format.json { render :json => @kittens }
		end
	end

	def show
		@kitten = Kitten.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render :json => @kitten }
		end
	end

	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)
		if @kitten.save
			flash[:success] = "You've created a new kitten!"
			redirect_to @kitten
		else
			flash.now[:danger] = "You've made a mistake. Try again."
			render 'new'
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:success] = 'Your kitten has been updated!'
			redirect_to @kitten
		else
			flash.now[:danger] = 'Update failed. Try again.'
			render 'edit'
		end
	end

	def destroy
		Kitten.find(params[:id]).destroy
		flash[:success] = 'Kitten destroyed.'
		redirect_to root_path
	end

	private

	def kitten_params
		params.require(:kitten).permit(:name, :age, :cuteness, :softness)
	end
end

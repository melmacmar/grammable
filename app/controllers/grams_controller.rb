class GramsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gram, only: [:edit, :update, :destroy]
  
  def destroy
    @gram.destroy
    redirect_to root_path
  end
  
  def update
    if @gram.update(gram_params)
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end
  
  def new
    @gram = Gram.new
  end
  
  def index
    @grams = Gram.all
  end
  
  def show
    @gram = Gram.find(params[:id])
  end
  
  def edit
  end
  
  def create
    @gram = Gram.create(gram_params.merge(user: current_user))
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def set_gram
    @gram = Gram.find(params[:id])
    render text: 'You do not have permission for this action.', status: :forbidden if @gram.user != current_user
  end
  
  def gram_params
    params.require(:gram).permit(:message, :picture)
  end
end

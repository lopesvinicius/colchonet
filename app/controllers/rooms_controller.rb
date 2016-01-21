class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

 def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room,
      notice: 'Successfully registered!'
    else
      render action: :new
    end
  end

  def update
    set_room

    if @room.update(room_params)
      redirect_to @room, notice: 'Succesfully changed!'
    else
      render action: :edit    
    end 
    
  end

  def destroy
      set_room
      @room.destroy
      redirect_to @room,
      notice: 'Succesfully deleted!'
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end

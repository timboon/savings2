class SavingsController < ApplicationController
  before_action :set_saving, only: [:show, :edit, :update, :destroy]

  # GET /savings
  # GET /savings.json
  def index
    @savings = Saving.all
  end

  # GET /savings/1
  # GET /savings/1.json
def show
  # Find the goal value out of the DB and then split it up over 27 weeks
  start_date = User.where(id: params[:user_id]).pluck(:start_date)
  end_date = User.where(id: params[:user_id]).pluck(:end_date)
  goal = User.where(id: params[:user_id]).pluck(:goal)
  
  goal_array = Array.new(2){Array.new(2)}
  goal_array[0][0]= start_date.last
  goal_array[1][0]= end_date.last
  goal_array[0][1] = 0
  goal_array[1][1] = goal.last
  
  @goal_array = goal_array
  # Find the saving data from the DB and associated week value, sort ASC
  data = Saving.where(user_id: params[:user_id]).pluck(:week,:amount)
  @data_sorted = data.sort {|x,y| x[0] <=> y[0] }
  
  # Cumulative sum of values - running total
  for i in 1..@data_sorted.length-1
    var1= @data_sorted[i][1]
    var2= @data_sorted[i-1][1]
    @data_sorted[i][1] = var1 + var2
  end
  
  #Convert the date into a string to parse
  #convert the string to UTC in milliseconds as per Java requirements
  for i in 0..@data_sorted.length-1
   # @data_sorted[i][0] = @data_sorted[i][0].strftime('%F')
   @data_sorted[i][0] = @data_sorted[i][0].to_s
    @data_sorted[i][0] = Time.parse(@data_sorted[i][0]).utc.to_i*1000
  end
  
  for i in 0..goal_array.length-1
    goal_array[i][0] = goal_array[i][0].strftime('%F')
    goal_array[i][0] = Time.parse(goal_array[i][0]).utc.to_i*1000
  end
  
  #date = Date.today.strftime('%F')
  date = Date.today.strftime('%F')
  current_date = Time.parse(date).to_s
  
  # Prepare highcharts with data from database
  @chart = LazyHighCharts::HighChart.new('graph') do |f|
  f.title({:text=>"Savings Progress"})
  
  f.yAxis [{
    title: {text: "Money Saved ($)" },
    
    min:0,
  }]
 
    f.xAxis [{
      type: 'datetime',
       #tickInterval: 5*7*24 * 3600 * 1000,
       

    plotLines: [{
        color: '#FF0000',
        width: 1,
        value: [current_date],
      
    }]

                     
    }]



#    f.xAxis(type: 'datetime', 
 # dateTimeLabelFormats: {second: '%l:%M:%S %p',
  #                   minute: '%l:%M %p', 
   #                  hour: '%l:%M %p',
    #                 day: '%e. %b', week: '%e. %b', 
     #                month: '%b \'%y', year: '%Y'})
                     
 # f.labels(:items=>[:html=>"Today's date in red", :style=>{:left=>"10px", :top=>"8px", :color=>"black"} ])      
  
  f.series(:type=> 'line',:name=> 'Savings to Date', :data=> @data_sorted)
  f.series(:type=> 'spline',:name=> 'Goal Savings', :data=> goal_array)
  f.series(:type=> 'line',:name=> 'Todays Date', :color=> 'red', :showSymbol=> 'false', :data=> 0)
  end
end 




# GET /savings/new
def new
  @saving = Saving.new
  end
  
  # GET /savings/1/edit
  def edit
  end
  
  # POST /savings
  # POST /savings.json
  def create
  
  
  @user = User.find( params[:user_id] )
  # weeks_year=Date.parse(params[:saving][:week]).strftime("%U")
  
  @saving = @user.saving.build( saving_params )
  #@saving = @user.saving.build( saving_params.merge(:week => weeks_year))
  
  respond_to do |format|
    if @saving.save
    format.html { redirect_to root_path, notice: 'Saving was successfully created.' }
    format.json { render :show, status: :created, location: @saving }
    else
    format.html { render :new }
    format.json { render json: @saving.errors, status: :unprocessable_entity }
  end
  end
end

# PATCH/PUT /savings/1
# PATCH/PUT /savings/1.json
def update
#respond_to do |format|
#if @saving.update(saving_params)
#  format.html { redirect_to @saving, notice: 'Saving was successfully updated.' }
#   format.json { render :show, status: :ok, location: @saving }
#  else
#   format.html { render :edit }
#    format.json { render json: @saving.errors, status: :unprocessable_entity }
#  end
#end
end

  # DELETE /savings/1
  # DELETE /savings/1.json
  def destroy
    #@saving.destroy
    #respond_to do |format|
     # format.html { redirect_to savings_url, notice: 'Saving was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_saving
    @user = User.find( params[:user_id] )
  
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def saving_params
   params.fetch(:saving, {}).permit(:week,:amount)
  end
end

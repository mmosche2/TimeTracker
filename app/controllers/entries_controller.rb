class EntriesController < ApplicationController
  
  before_filter :authorize
  
  def index
	
	if (!params[:from].blank? && !params[:to].blank?)
		@myfrom = convert_date(params[:from])
		@myto = convert_date(params[:to])
	elsif (!params[:myfrom].blank? && !params[:myto].blank?)
		@myfrom = Date.strptime(params[:myfrom], "%Y-%m-%d") 
		@myto = Date.strptime(params[:myto], "%Y-%m-%d") 
	else
		@myfrom = Date.today.beginning_of_month
		@myto = Date.today
	end
	
	@entries = current_user.entries.where("cal_date >= ? AND cal_date <= ?", @myfrom, @myto).order("cal_date ASC")
  
    if (!params[:project].blank?)		
		@filter_project = params[:project]
		@entries = @entries.where("project_id = ?", @filter_project)
	else
		@filter_project = ""
	end
	
	@projects = find_my_projects_sum
	
	@hrs_sum = 0
	@entries.each do |entry|
		@hrs_sum = @hrs_sum + entry.hours
	end
		
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
	@projects = find_my_projects
  end

  def edit
    @entry = Entry.find(params[:id])
	@projects = find_my_projects
  end

  def create
    @entry = Entry.new(params[:entry])

	if @entry.save
		redirect_to entries_url, notice: 'Entry was successfully created.' 
	else
		render action: "new" 
	end
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update_attributes(params[:entry])
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render action: "edit" 
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to entries_url 
  end
  
  private
	
	def find_my_projects_sum
		# returns a mapping [project name, id, sum of hours]
		current_user.projects.map{
			|p|[p.name, p.id, p.entries.where("cal_date >= ? AND cal_date <= ?", @myfrom, @myto).reduce(0) do |sum, entry| 
					sum = sum + entry.hours 
				end
			]
		}
	end
	
	def find_my_projects
		# returns a mapping [project name, id]
		current_user.projects.map{|p|[p.name, p.id]}
	end
	
	def convert_date(obj)
	  return Date.new(obj['(1i)'].to_i,obj['(2i)'].to_i,obj['(3i)'].to_i)
	end
	
end

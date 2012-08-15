class ReportedItemsController < ApplicationController
  
  def index
    @reported_items = ReportedItem.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def new
    @tagged_item = TaggedItem.find(params[:item])
    @reported_item = ReportedItem.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    params[:reported_item][:tagged_item] = TaggedItem.find_by_title(params[:reported_item][:tagged_item])
    params[:reported_item][:user] = User.find_by_email(params[:reported_item][:user])
    @reported_item = ReportedItem.new(params[:reported_item])

    respond_to do |format|
      if @reported_item.save
        format.html { redirect_to tagged_items_path, notice: 'Item was successfully reported.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def destroy
    @reported_item = ReportedItem.find(params[:id])
    @reported_item.destroy

    respond_to do |format|
      format.html { redirect_to reported_items_url }
      format.json { head :no_content }
    end
  end
  
end

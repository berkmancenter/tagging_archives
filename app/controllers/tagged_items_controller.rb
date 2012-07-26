class TaggedItemsController < ApplicationController
  before_filter :authenticate_user!

  # GET /tagged_items
  # GET /tagged_items.json
  def index
    @tagged_items = TaggedItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tagged_items }
    end
  end

  # GET /tagged_items/1
  # GET /tagged_items/1.json
  def show
    @tagged_item = TaggedItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tagged_item }
    end
  end

  # GET /tagged_items/new
  # GET /tagged_items/new.json
  def new
    @tagged_item = TaggedItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tagged_item }
    end
  end

  # GET /tagged_items/1/edit
  def edit
    @tagged_item = TaggedItem.find(params[:id])
  end

  # POST /tagged_items
  # POST /tagged_items.json
  def create
    @tagged_item = TaggedItem.new(params[:tagged_item])

    respond_to do |format|
      if @tagged_item.save
        format.html { redirect_to @tagged_item, notice: 'Tagged item was successfully created.' }
        format.json { render json: @tagged_item, status: :created, location: @tagged_item }
      else
        format.html { render action: "new" }
        format.json { render json: @tagged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tagged_items/1
  # PUT /tagged_items/1.json
  def update
    @tagged_item = TaggedItem.find(params[:id])

    respond_to do |format|
      if @tagged_item.update_attributes(params[:tagged_item])
        format.html { redirect_to tagged_items_url, notice: 'Tagged item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tagged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tagged_items/1
  # DELETE /tagged_items/1.json
  def destroy
    @tagged_item = TaggedItem.find(params[:id])
    @tagged_item.destroy

    respond_to do |format|
      format.html { redirect_to tagged_items_url }
      format.json { head :no_content }
    end
  end
  
  def item_search
    @query = params[:query]
    @search = TaggedItem.search do
      fulltext params[:query]
      paginate :page => 1, :per_page => 10
    end
    
  end
  
  def all_tags
    @tags = TaggedItem.tag_counts_on(:tags)
  end
  
  def all_items
    @tagged_items = TaggedItem.all
  end
  
end

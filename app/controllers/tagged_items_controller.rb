class TaggedItemsController < ApplicationController
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
        format.html { redirect_to @tagged_item, notice: 'Tagged item was successfully updated.' }
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

    if params[:junction_type].blank?
      params[:junction_type] = 'and'
    end
    # no code injection here.
    junction_type_map = {'and' => 'all_of', 'or' => 'any_of'}

    unless params[:include_tag_ids].blank?
      include_tags = params[:include_tag_ids]
    end

    unless params[:q].blank?
      keywords = params[:q]
    end

    if ! include_tags.blank? || ! keywords.blank?
      @search = TaggedItem.search
      hub_id = @tagged_item.id

      hub_context = @tagged_item.tagging_key

      @search.build do
        self.send((junction_type_map[params[:junction_type]].blank?) ? 'any_of' : junction_type_map[params[:junction_type]]) do
          unless include_tags.blank?
            with :tag_contexts, include_tags.collect{|it| %Q|#{hub_context}-#{it}|}
          end
          unless params[:q].blank?
            text_fields do
              any_of do
                with :title, params[:q]
                with :urn, params[:q]
                with :tag_list, params[:q]
              end
            end
          end
        end
      end

      @search.build do
        with :hub_ids, hub_id
        paginate :page => params[:page], :per_page => get_per_page
        order_by(:date_published, :desc)
      end

      @search.execute!
    end
    respond_to do|format|
      format.html{ render :layout => ! request.xhr? }
      format.json{ render_for_api :default, :json => (@search.blank?) ? [] : @search.results }
      format.xml{ render_for_api :default, :xml => (@search.blank?) ? [] : @search.results }
    end
  end
end

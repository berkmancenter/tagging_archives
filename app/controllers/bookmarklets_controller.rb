class BookmarkletsController < ApplicationController
  before_filter :authenticate_user!
  
  # Generate the bookmarklet.
  def add
    @existing = TaggedItem.find(:first, :conditions => {:urn => params[:tagged_item][:url]})
    @tagged_item = TaggedItem.new
    @title = params[:tagged_item][:title]
    @urn = params[:tagged_item][:url]
    @finding_aid = params[:tagged_item][:aid]
  end
  
  def add_item
    @tagged_item = TaggedItem.find(:first, :conditions => {:urn => params[:tagged_item][:urn]})
    if @tagged_item.nil? 
      @tagged_item = TaggedItem.new(params[:tagged_item])
    end
     
    # Merge notes.
    @tagged_item.notes = @tagged_item.notes+"\r"+params[:tagged_item][:notes]
    # Merge tags.
    @tagged_item.tag_list = [@tagged_item.tag_list, params[:tagged_item][:tag_list].split(/,\s*/).collect{|t| t.downcase[0,255].gsub(/,/,'_')}].flatten.compact.join(',')

    respond_to do|format|
      if @tagged_item.save
        flash[:notice] = 'Added that tagged item.'
        format.html {
          redirect_to bookmarklets_confirm_url(:tagged_item_id => @tagged_item.id) 
        }
      else
        format.html{
          render
        }
      end
    end
  end
  
  # The page that appears after a bookmark has been successfully added.
  def confirm
    @tagged_item = TaggedItem.find(params[:tagged_item_id])
  end
end

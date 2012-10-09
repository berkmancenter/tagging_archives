class BookmarkletsController < ApplicationController
  before_filter :authenticate_user!
  layout "bookmarklet"
  
  # Generate the bookmarklet.
  def add
    @existing = TaggedItem.find(:first, :conditions => {:urn => params[:tagged_item][:url]})
    @tagged_item = TaggedItem.new
    @title = params[:tagged_item][:title]
    @urn = params[:tagged_item][:urn]
  end
  
  def add_item
    p :title
    #@tagged_item = TaggedItem.find(:first, :conditions => {:urn => params[:tagged_item][:urn]})
    params[:tagged_item][:user_ids] = [current_user.id]
    @tagged_item = TaggedItem.new(params[:tagged_item])
    @existing = TaggedItem.find(:first, :conditions => {:urn => params[:tagged_item][:url]})
    @title = params[:tagged_item][:title]
    @urn = params[:tagged_item][:urn]
    #if @tagged_item.nil? 
    #  params[:tagged_item][:user_ids] = [current_user.id]
    #  @tagged_item = TaggedItem.new(params[:tagged_item])
    #else
      # Merge notes.
    #  @tagged_item.notes = @tagged_item.notes+"\r"+params[:tagged_item][:notes]
      # Merge tags.
    #  @tagged_item.tag_list = [@tagged_item.tag_list, params[:tagged_item][:tag_list].split(/,\s*/).collect{|t| t.downcase[0,255].gsub(/,/,'_')}].flatten.compact.join(',')
      # Merge users.
    #  @user = User.find(current_user.id)
    #  if !@tagged_item.users.include?(@user)
    #    @tagged_item.users << @user
    #  end 
    #end

    respond_to do|format|
      if @tagged_item.save
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

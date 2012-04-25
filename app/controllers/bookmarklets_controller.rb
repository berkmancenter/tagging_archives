class BookmarkletsController < ApplicationController
  
  # Generate the bookmarklet.
  def add
    @tagged_item = TaggedItem.new
  end
  
  def add_item
    @tagged_item = TaggedItem.new(params[:tagged_item])

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

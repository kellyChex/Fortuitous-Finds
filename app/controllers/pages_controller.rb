class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def search
    if !params[:search_string].nil?
        search_string = params[:search_string].strip.downcase
        search_string = search_string.gsub("'", "\''")
        @storage = Listing.joins(:user).where("LOWER(users.name) LIKE '%#{search_string}%' OR LOWER(listings.name) LIKE '%#{search_string}%'")
        render pages_search_path
    end
  end
end

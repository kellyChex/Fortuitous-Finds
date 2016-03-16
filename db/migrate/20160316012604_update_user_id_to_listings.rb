class UpdateUserIdToListings < ActiveRecord::Migration
  def change
    Listing.find_each do |listing|
      listing.update_attributes!(user_id: 2)
    end
  end
end

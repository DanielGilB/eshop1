class AddCoverImageAttachmentToDiscs < ActiveRecord::Migration
  def up
    add_attachment :discs, :cover_image
  end

  def down
    remove_attachment :discs, :cover_image
  end
end

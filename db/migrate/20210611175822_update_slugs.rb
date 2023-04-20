class UpdateSlugs < ActiveRecord::Migration[6.1]
  def up
    Post.find_each(&:save)
    Evenement.find_each(&:save)
  end
end

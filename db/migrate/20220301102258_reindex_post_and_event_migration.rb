class ReindexPostAndEventMigration < ActiveRecord::Migration[6.1]
  def change
    PgSearch::Multisearch.rebuild(Post)
    PgSearch::Multisearch.rebuild(Evenement)
  end
end

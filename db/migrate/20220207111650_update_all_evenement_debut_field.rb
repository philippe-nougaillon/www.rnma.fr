class UpdateAllEvenementDebutField < ActiveRecord::Migration[6.1]
  def change
    say "Migration in progess"
    Evenement.all.each{|e| e.update_attribute(:debut, e.le)}
  end
end

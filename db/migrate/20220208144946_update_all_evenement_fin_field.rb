class UpdateAllEvenementFinField < ActiveRecord::Migration[6.1]
  def change
    say "Migration in progess"
    Evenement.all.each{|e| e.update_attribute(:fin, e.le)}
  end
end

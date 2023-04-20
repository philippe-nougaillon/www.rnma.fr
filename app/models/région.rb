class Région < ApplicationRecord

    def self.import
        require 'csv'

        CSV.foreach('db/departements-region.csv', headers: true) do |row|
            Région.create(row.to_h)
        end
    end

end

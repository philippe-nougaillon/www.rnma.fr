module RegionsConcern
    extend ActiveSupport::Concern

    included do
        before_save :maj_région, if: :cp_not_nil?
    end

    def cp_not_nil?
        !(self.cp.blank?)
    end

    # Rechercher la région et le département d'après le code postal
    def maj_région
        # France métro, on prend les 2 premiers chiffres
        num_dep = self.cp[0..1].to_i
        # Si outre-mer, on garde les 3 premiers chiffres
        num_dep = self.cp[0..2].to_i if num_dep == 97 

        if region = Région.find_by(num_dep: num_dep)
            self.dep_name = region.dep_name
            self.region_name = region.region_name
        end
    end

end
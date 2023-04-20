# frozen_string_literal: true

module AdhesionDecorator
    def style
        self.current_state.meta[:style]
    end

    def maison_organisme
        self.maison_id ? Maison.unscoped.find(self.maison_id).nom : self.organisme
    end
end

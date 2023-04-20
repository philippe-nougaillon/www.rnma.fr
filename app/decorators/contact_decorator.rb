# frozen_string_literal: true

module ContactDecorator
  def prénom_nom
    "#{ self.prénom } #{ self.nom }"
  end
end

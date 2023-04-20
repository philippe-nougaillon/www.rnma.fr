# frozen_string_literal: true

module RessourceDecorator
  def style
    self.current_state.meta[:style]
  end
end

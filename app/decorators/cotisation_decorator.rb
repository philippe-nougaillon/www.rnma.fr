# frozen_string_literal: true

module CotisationDecorator
  def style
    self.current_state.meta[:style]
  end
end

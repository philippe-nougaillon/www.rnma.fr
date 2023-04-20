# frozen_string_literal: true

module PublicationDecorator
  def style
    self.current_state.meta[:style]
  end
end

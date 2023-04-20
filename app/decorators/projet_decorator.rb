# frozen_string_literal: true

module ProjetDecorator
  def style
    self.current_state.meta[:style]
  end
end

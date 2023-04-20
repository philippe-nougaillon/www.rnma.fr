# frozen_string_literal: true

module MessageDecorator
  def style
    self.current_state.meta[:style]
  end
end

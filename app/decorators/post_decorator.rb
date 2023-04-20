# frozen_string_literal: true

module PostDecorator
  def style
    self.current_state.meta[:style]
  end
end

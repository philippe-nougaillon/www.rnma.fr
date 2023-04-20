# frozen_string_literal: true

require 'test_helper'

class ActionDecoratorTest < ActiveSupport::TestCase
  def setup
    @action = Action.new.extend ActionDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

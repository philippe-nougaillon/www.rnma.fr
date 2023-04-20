# frozen_string_literal: true

require 'test_helper'

class AdhesionDecoratorTest < ActiveSupport::TestCase
  def setup
    @adhesion = Adhesion.new.extend AdhesionDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

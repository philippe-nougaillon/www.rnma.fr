# frozen_string_literal: true

require 'test_helper'

class EvenementDecoratorTest < ActiveSupport::TestCase
  def setup
    @evenement = Evenement.new.extend EvenementDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

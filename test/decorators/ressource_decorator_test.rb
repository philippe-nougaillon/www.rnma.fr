# frozen_string_literal: true

require 'test_helper'

class RessourceDecoratorTest < ActiveSupport::TestCase
  def setup
    @ressource = Ressource.new.extend RessourceDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

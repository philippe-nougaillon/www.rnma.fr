# frozen_string_literal: true

require 'test_helper'

class CotisationDecoratorTest < ActiveSupport::TestCase
  def setup
    @cotisation = Cotisation.new.extend CotisationDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

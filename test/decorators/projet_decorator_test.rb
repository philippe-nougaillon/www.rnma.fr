# frozen_string_literal: true

require 'test_helper'

class ProjetDecoratorTest < ActiveSupport::TestCase
  def setup
    @projet = Projet.new.extend ProjetDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

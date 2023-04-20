# frozen_string_literal: true

require 'test_helper'

class PublicationDecoratorTest < ActiveSupport::TestCase
  def setup
    @publication = Publication.new.extend PublicationDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

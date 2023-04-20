# frozen_string_literal: true

require 'test_helper'

class ContactDecoratorTest < ActiveSupport::TestCase
  def setup
    @contact = Contact.new.extend ContactDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

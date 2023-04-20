ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 0)

  Capybara.enable_aria_label = true

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    @admin_pe = User.create(email: 'p-edacquet@hotmail.fr', password: '12345ZEIMFJ67U', password_confirmation: '12345ZEIMFJ67U',approved: true, admin: true, confirmed_at: DateTime.now)
    @MDA_sophie = User.create(email: 'sophie.lebrun@gmail.fr', password: '1A2Z3E4R5T6Y7U8I9O', password_confirmation: '1A2Z3E4R5T6Y7U8I9O',approved: true, confirmed_at: DateTime.now)
    @member_marc = User.create(email: 'marc.perrier@gmail.fr', password: '9g2dLs9SU', password_confirmation: '9g2dLs9SU',approved: true, confirmed_at: DateTime.now)

  end

  def login_user_admin_controller
    post new_user_session_path, params: { user: { user_email: @admin_pe.email, user_password: @admin_pe.password } }
  end


  def login_user_admin
    visit new_user_session_path
    fill_in 'user_email', with: @admin_pe.email
    fill_in 'user_password', with: @admin_pe.password
    click_on 'Se connecter'
  end

  def login_user_member
    visit new_user_session_path
    fill_in 'user_email', with: @MDA_sophie.email
    fill_in 'user_password', with: @MDA_sophie.password
    click_on 'Se connecter'
  end

  def login_user_member_without_maison
    visit new_user_session_path
    fill_in 'user_email', with: @member_marc.email
    fill_in 'user_password', with: @member_marc.password
    click_on 'Se connecter'
  end
  # Add more helper methods to be used by all tests here...
end

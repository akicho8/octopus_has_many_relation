# -*- coding: utf-8 -*-
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Octopus.using" do
    user = User.using(:master).create!
    Article.using("green").create!(:user => user)
    Octopus.using("green") do
      assert_equal 1, user.articles.count
    end
  end
end

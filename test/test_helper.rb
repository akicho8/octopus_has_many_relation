# -*- coding: utf-8 -*-
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module OctopusHelper
  extend self

  def clean_all_shards
    shards = User.using(:master).connection.instance_variable_get(:@shards).keys
    shards.each do |shard|
      ["users", "articles"].each do |table|
        silence_stream(STDOUT) do
          User.using(shard).connection.tap do |e|
            e.execute("DELETE FROM #{table}")
          end
        end
      end
    end
  end

  def clean_connection_proxy
    Thread.current['octopus.current_model']       = nil
    Thread.current['octopus.current_shard']       = nil
    Thread.current['octopus.current_group']       = nil
    Thread.current['octopus.current_slave_group'] = nil
    Thread.current['octopus.block']               = nil
    Thread.current['octopus.last_current_shard']  = nil

    ActiveRecord::Base.class_variable_set(:@@connection_proxy, nil)
  end
end

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

class ActiveSupport::TestCase
  self.use_transactional_fixtures = false

  setup do
    OctopusHelper.clean_all_shards
    OctopusHelper.clean_connection_proxy
  end
end

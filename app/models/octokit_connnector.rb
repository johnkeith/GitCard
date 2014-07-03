class OctokitConnector < ActiveRecord::Base
  def self.create(user)
    Octokit::Client.new(access_token: user.access_token, auto_paginate: true)
  end
end

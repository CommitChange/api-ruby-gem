require './lib/cc_api.rb'
require 'pg'
require 'minitest/autorun'
require 'pry'

class CCAPITest < Minitest::Test

  # Run the API server locally on port 4567
  def setup
    CCAPI.config({
      email: 'jay@commitchange.com',
      password: 'password'
    }, "http://localhost:4567")
  end
  
  def test_get
    data = CCAPI.get("/nonprofits/profile", {
      query: {id: 4341, select: 'name'}
    })
    assert_equal 'PRX, Inc.', data['name']
  end
  def test_post
  end
  def test_patch
  end
  def test_delete
  end
end

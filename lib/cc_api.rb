require 'json'
require 'httparty'
require 'active_support/hash_with_indifferent_access'

module CCAPI

  def self.config(options, base_uri='https://api.commitchange.com')
    @options = HashWithIndifferentAccess.new(options)
    @uri = base_uri
    # Login and get JWT
    auth(@uri, @options)
  end

  def self.auth(uri, opts)
    resp = HTTParty.post(uri + "/auth", {
      body: {
        email: opts[:email],
        password: opts[:password]
      }
    })
    raise CCAPI::Error.new("Unable to authenticate: #{resp.body}") if resp.code != 200
    json = JSON.parse(resp.body)
    @defaults = {
      headers: { 'Authentication' => json['jwt'] }
    }
  end

  def self.request(path, params, method)
    resp = HTTParty.send(method, @uri + path, params.merge(@defaults))
    if resp.code == 440 # token expired, re-auth
      auth(@uri, @options) 
      resp = HTTParty.send(method, @uri + path, params.merge(@defaults))
    end
    JSON.parse(resp.body)
  end

  def self.get(path, params)
    request(path, params, :get)
  end
  def self.post(path, params)
    request(path, params, :post)
  end
  def self.patch(path, params)
    request(path, params, :patch)
  end
  def self.delete(path, params)
    request(path, params, :get)
  end

  # CCAPI::Error
  class Error < RuntimeError
  end

end


This is a simple ruby gem (a wrapper around HttParty) that allows easy and quick access to the CC API. It isn't available on rubygems, but can be installed using git

`gem 'cc-api', git: 'git://github.com/commitchange/cc-api-ruby-gem.git'`

First, configure your credentials:

```rb
require 'cc-api'

CCAPI.config({
  email: ENV['api_user_account_email'],
  password: ENV['api_user_account_password']
})
```

Now you will be able to make requests to the api (depending on your access permissions):


All functions take a hash as the second parameter. The hashes for `.post` and `.patch` take a `query` key in the hash to send data. These function calls return an array of data (it is always an array, and may contain only one element). The keys within the resulting array are `HashWithIndifferentAccess`:

```rb
id = CCAPI.post("/supporters", {
  name: 'Bob Ross'
}).last[:id]

bob = CCAPI.patch("/supporters", {
  id: id,
  name: 'Robert Norman "Bob" Ross'
}).last
```

The `.get` function takes a `query` key in the hash for passing data, instead of body:

```rb
bob = CCAPI.get("/supporters", {
  query: {id: id, select: 'name'}
})
# -> [ { name: 'Robert Norman "Bob" Ross' } ]
```


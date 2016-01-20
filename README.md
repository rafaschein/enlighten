# enlighten

[![Build Status](https://travis-ci.org/CWISoftware/enlighten.svg?branch=master)](https://travis-ci.org/CWISoftware/enlighten)
[![Code Climate](https://codeclimate.com/github/CWISoftware/enlighten/badges/gpa.svg)](https://codeclimate.com/github/CWISoftware/enlighten)
[![Test Coverage](https://codeclimate.com/github/CWISoftware/enlighten/badges/coverage.svg)](https://codeclimate.com/github/CWISoftware/enlighten/coverage)
[![Dependency Status](https://gemnasium.com/CWISoftware/enlighten.svg)](https://gemnasium.com/CWISoftware/enlighten)

**Enlighten** aims to enhance organizational culture by providing a platform to disseminate great attitudes, technologies and ideas between projects and teams of an organization.

## Technologies

[<img src="https://upload.wikimedia.org/wikipedia/commons/c/c3/Ruby_on_Rails_logo.svg" width="100" height="100">](http://rubyonrails.org/)
[<img src="https://raw.githubusercontent.com/rspec/rspec.github.io/source/source/images/logo.png" width="100" height="100">](http://rspec.info/)
[<img src="https://avatars2.githubusercontent.com/u/320565?v=3&s=200" width="100" height="100">](https://cucumber.io/)
[<img src="https://avatars3.githubusercontent.com/u/3709251?v=3&s=200" width="100" height="100">](https://github.com/bower)

## Usage

If you want to contribute to Enlighten or run it from source, clone this repository to your machine:

    $ git clone https://github.com/CWISoftware/enlighten.git
    $ cd enlighten
    $ bundle
    $ rails s

## Contributing

We appreciate any contribution to Enlighten, so check out our [CONTRIBUTING.md](CONTRIBUTING.md) guide for more information. We usually keep a list of features and bugs [in the issue tracker](https://github.com/CWISoftware/enlighten/issues).

## Communication

### Chat

[![Join the chat at https://gitter.im/CWISoftware/enlighten](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/CWISoftware/enlighten?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

### Stories

[![Stories in Ready](https://badge.waffle.io/CWISoftware/enlighten.png?label=ready&title=Ready)](https://waffle.io/CWISoftware/enlighten)

## Development Environment Setup

[<img src="https://upload.wikimedia.org/wikipedia/commons/8/87/Vagrant.png" width="50" height="50">](https://github.com/CWISoftware/enlighten-vagrant)

```bash
# install the dependencies
bower install
bundle install

# run tests
rake

# create database and execute migrations
rake db:create
rake db:migrate

# create permission seed
rake db:seed

# create seed records for development environment on the database
rake db:seed:development

# execute development server
rails s -b 0.0.0.0

# access localhost:3000 on you browser

# login with:
#   User email: test@test.com
#   User password: 12345678
```

## Important links

* [CWI Software Website][1]
* [Enlighten Website][2]
* [Issue Tracker][3]
* [Chat][4]
* [Stories][5]
* [Vagrant][6]
* [Puppet][7]

  [1]: http://www.cwi.com.br
  [2]: https://enlighten-prototype.herokuapp.com
  [3]: https://github.com/CWISoftware/enlighten/issues
  [4]: https://gitter.im/CWISoftware/enlighten
  [5]: https://waffle.io/CWISoftware/enlighten
  [6]: https://github.com/CWISoftware/enlighten-vagrant
  [7]: https://github.com/CWISoftware/enlighten-vagrant-puppet

## License

Enlighten source code is released under MIT License.

Check [LICENSE](LICENSE) files for more information.

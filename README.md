[![Stories in Ready](https://badge.waffle.io/CWISoftware/enlighten.png?label=ready&title=Ready)](https://waffle.io/CWISoftware/enlighten)
# enlighten

[![Join the chat at https://gitter.im/CWISoftware/enlighten](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/CWISoftware/enlighten?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/CWISoftware/enlighten.svg?branch=master)](https://travis-ci.org/CWISoftware/enlighten)
[![Code Climate](https://codeclimate.com/github/CWISoftware/enlighten/badges/gpa.svg)](https://codeclimate.com/github/CWISoftware/enlighten)
[![Test Coverage](https://codeclimate.com/github/CWISoftware/enlighten/badges/coverage.svg)](https://codeclimate.com/github/CWISoftware/enlighten/coverage)


This project aims to enhance organizational culture by providing a platform to disseminate great attitudes, technologies and ideas between projects and teams of an organization.

# Technologies
* Framework: [Ruby on Rails](http://guides.rubyonrails.org/)
* Unit testing: [Rspec](http://rspec.info/)
* BDD: [Cucumber](https://cucumber.io/)

# Development Setup
## Unix
```
# install postgres
brew install...
apt-get...
yum...

# install rvm (ruby version manager)
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

# clone project
git clone git@github.com:dwayhs/enlighten.git

# access project folder (rvm initializes gemset)
cd enlighten

# install the dependencies
bundle install

# run tests
rake

# create database and execute migrations (needs an accessible postgresql server)
rake db:create
rake db:migrate
```

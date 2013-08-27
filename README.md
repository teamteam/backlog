# Backlog

## Configure your environment

Install the Ruby

    $ rvm install `cat .ruby-version`

Create and use a gemset

    $ rvm use `cat .ruby-version`@`cat .ruby-gemset` --create

Install node and npm (on Mac OS X)

    $ brew install node

Install node depencies

    $ npm install

Bower dependencies (note that this runs automatically when you run npm install)

    $ ./bin/bower_install

## Test your code

Run all of the tests with the following command:

    $ bundle exec rake spec

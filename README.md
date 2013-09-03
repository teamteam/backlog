# Backlog

## Configure your environment

Install the Ruby

    $ rvm install `cat .ruby-version`

Create and use a gemset

    $ rvm use `cat .ruby-version`@`cat .ruby-gemset` --create

Install mailcatcher

    $ gem install mailcatcher

Run mailcatcher when necessary

    $ mailcatcher
    Starting MailCatcher
    ==> smtp://127.0.0.1:1025
    ==> http://127.0.0.1:1080
    *** MailCatcher runs as a daemon by default. Go to the web interface to quit.

Install node and npm (on Mac OS X)

    $ brew install node

Install node depencies

    $ npm install

Bower dependencies (note that this runs automatically when you run npm install)

    $ ./bin/bower_install

## Test your code

Write features and specs.

Run the feature tests with:

    $ bundle exec rake cucumber

Run the spec tests with:

    $ bundle exec rake spec

Run all of the tests with:

    $ ./bin/test

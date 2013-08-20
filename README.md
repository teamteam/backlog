# Backlog

## Configure your environment

Install the Ruby

    $ rvm install `cat .ruby-version`

Create and use a gemset

    $ rvm use `cat .ruby-version`@`cat .ruby-gemset` --create

## Test your code

Generate a feature spec with the following command:

    $ rails generate mini_test:feature NameOfYourFeature --spec

Run all of the tests with the following command:

    $ rake minitest:all

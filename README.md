# eotc-helper
[![GitHub (pre-)release](https://img.shields.io/github/release/spotswoodcollege/eotc-helper/all.svg)](https://github.com/SpotswoodCollege/eotc-helper/releases)
[![In Development](https://img.shields.io/badge/stage-development-blue.svg)](https://github.com/SpotswoodCollege/eotc-helper/releases)
[![Join the chat at https://gitter.im/SpotswoodCollege/eotc-helper](https://badges.gitter.im/SpotswoodCollege/eotc-helper.svg)](https://gitter.im/SpotswoodCollege/eotc-helper?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Education Outside the Classroom Helper is a Rails app for helping teachers organize class trips, without lots of paperwork. It is currently unfinished.

## Status

[![Build Status](https://travis-ci.org/SpotswoodCollege/eotc-helper.svg?branch=master)](https://travis-ci.org/SpotswoodCollege/eotc-helper)
[![Coverage Status](https://coveralls.io/repos/github/SpotswoodCollege/eotc-helper/badge.svg?branch=master)](https://coveralls.io/github/SpotswoodCollege/eotc-helper?branch=master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7abad57177164b1ca907c8b0d1d50f53)](https://www.codacy.com/app/microlith57/eotc-helper?utm_source=github.com&utm_medium=referral&utm_content=SpotswoodCollege/eotc-helper&utm_campaign=Badge_Grade)
[![codebeat badge](https://codebeat.co/badges/93f88656-53ef-478e-b239-519107b62f82)](https://codebeat.co/projects/github-com-spotswoodcollege-eotc-helper-master)
[![Inline docs](http://inch-ci.org/github/SpotswoodCollege/eotc-helper.svg?branch=master)](http://inch-ci.org/github/SpotswoodCollege/eotc-helper)

The eotc-helper app is currently in development.

## Features

The eotc-helper app will allow authorized users (teachers and above) to create trips. This will involve a form for trip specification, as well as a notification system to automatically notify the EOTC coordinator, the Board of Trustees, and lower-level associated accounts (students in associated groups or classes).

The app will be built around a user model, with accounts of differing privilege levels.

-   Students can subscribe to notifications and comment on trips
-   Teachers can create trips
-   BoT members and the EOTC coordinator can remove, edit, and approve trips

All accounts have the privileges of lesser accounts. Accounts can only be escalated to higher permission levels by the System Administrator. Anyone can register a student account.

## Contribution

For information about how to contribute, see our [Contribution guidelines](.github/CONTRIBUTING.md) and [Code of Conduct](.github/CODE_OF_CONDUCT.md).

There is a public chatroom for discussion [on Gitter](https://gitter.im/SpotswoodCollege/eotc-helper).

## Dependencies

This app runs on Ruby 2.3 with Rails 5.2.0. Other dependency information is available in the [Gemfile](Gemfile). To install all dependencies, run `gem install bundler` and then `bundle install`. Further, the app requires a database. See the Database Creation section below.

## Configuration

### Databases in Development

In the development phase, it is recommended to use SQLite. This does not require a command to create its database, but to use it, you must set the environment variables `$RAILS-ENV` to `development` and `$DB` to `sqlite`:

```bash
export RAILS_ENV=development
export DB=sqlite
```

### Server

To run the Rails server, run `rails server`. Should this fail, run `bin/rails server`. Remember that you must be in the eotc-helper directory.

## Testing

This repository is set up to use [Travis CI](https://travis-ci.org/SpotswoodCollege/eotc-helper) for continuous integration. However, local testing is encouraged.

To test your code locally, run ```rails test```, and to lint it, run ```rubocop -a -c .rubocop/yml```.

### Database Creation

There are three supported database packages: SQLite, mysql, and postgresql. To switch between them, set the `$DB` environment variable. If the environment variable is not set, the default database is `postgresql`. To use a database package, it must be installed.

To create the database, run

```bash
bundle exec
rake db:create
```

### Database Initialization

To initialize the database, run

```bash
rake db:migrate
```

### Test Suite

To run the test suite, use

```bash
RAILS_ENV=test
rake --trace db:migrate test
```

This sets the environment to a testing environment, and executes the tests. This script is automatically exected by our Continuous Integration software (currently [Travis CI]((https://travis-ci.org/SpotswoodCollege/eotc-helper)).

## Deployment

### Database Creation

For deployment, it is recommended to use PostgreSQL, as it is most suited to the deployment phase. To create the production database, use:

```bash
bundle exec
rake db:create
```

You must also set the environment variables:

```bash
export RAILS_ENV=production
export DB=postgresql
```

### Database Initialization

Simply run:

```bash
rake db:migrate
```

### Server

Running a production server is currently impossible.

## This Repository

This repository makes use of the following tools:

-   [Travis CI](https://travis-ci.org/SpotswoodCollege/eotc-helper) for continuous integration
-   [Coveralls](https://coveralls.io/github/SpotswoodCollege/eotc-helper?branch=master) for code coverage
-   [Codacy](https://www.codacy.com/app/microlith57/eotc-helper) and [codebeat](https://codebeat.co/projects/github-com-spotswoodcollege-eotc-helper-master) for code review
-   [Inch CI](https://inch-ci.org/github/SpotswoodCollege/eotc-helper) for documentation review
-   [Synk](https://snyk.io/) for security
-   [Dependabot](https://app.dependabot.com/) for dependency management
-   [ZenHub](https://www.zenhub.com/) for project management

In addition, the project uses the following command line utilities:

-   [Rubocop](https://github.com/rubocop-hq/rubocop) for style checks

as well as various other utilities, specified in the [Gemfile](Gemfile).

## Thanks!

Thanks to all the wonderful resources we are using!

-   [Rails Guides](http://guides.rubyonrails.org/)
-   [Rails Tutorial](https://www.railstutorial.org/)

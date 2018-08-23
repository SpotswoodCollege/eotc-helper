# eotc-helper
[![GitHub (pre-)release](https://img.shields.io/github/release/spotswoodcollege/eotc-helper/all.svg)](https://github.com/SpotswoodCollege/eotc-helper/releases)
[![In Development](https://img.shields.io/badge/stage-development-blue.svg)](https://github.com/SpotswoodCollege/eotc-helper/releases)
[![Join the chat at https://gitter.im/SpotswoodCollege/eotc-helper](https://badges.gitter.im/SpotswoodCollege/eotc-helper.svg)](https://gitter.im/SpotswoodCollege/eotc-helper?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-909090.svg)](https://github.com/semantic-release/semantic-release)
<!-- [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) upon first release -->

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

### Commit Guidelines

This repository uses Commitizen. To make a commit, you will need to follow the format.

First, install Commitizen:

```bash
npm install --global commitizen
```

Then, each time you commit, use

```bash
git-cz -s
```

instead of ```git commit``` and follow the command line instructions. This system ensures simple, machine-readable commits, and also [Developer Certificate of Origin](https://developercertificate.org/) signing. These formats are mandatory for PR acceptance.

## Dependencies

This app runs on Ruby 2.3 with Rails 5.2.0. Other dependency information is available in the [Gemfile](Gemfile). Dependency installation is included in the setup and update phases. This application also requires a PostgreSQL database.

## Configuration

### Setup

To setup the environment, run:

```bash
export RAILS_ENV=development
bin/setup
```

### Update from an Earlier Version

When updating from an earlier version of eotc-helper, run

```bash
export RAILS_ENV=development
bin/update
```

### Server

To run the Rails server, run `rails server`. Should this fail, run `bin/rails server`.

## Testing

This repository is set up to use [Travis CI](https://travis-ci.org/SpotswoodCollege/eotc-helper) for continuous integration. However, local testing is encouraged.

To test your code locally, run ```rake test```, and to lint it, run ```rubocop -a -c .rubocop/yml```.

## Deployment

### Database Creation

To create the production database, use:

```bash
bin/setup
```

Or, if updating from an earlier version:

```bash
bin/update
```

You must also set the rails environment variable:

```bash
export RAILS_ENV=production
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

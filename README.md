# Grailed Backend Challenge

CLI that finds users with disallowed and duplicate usernames in the database and
transforms them into valid usernames.

## Overview

For this CLI I chose Ruby. I feel comfortable working in Ruby, and I have made
simple CLIs in Ruby before.

You will notice that this app uses one singleton class. I've decided for this
approach because I wanted to make sure that the database connection is established
only once. The rest of the code is written in functions, as the given task is
not complex enough to use classes.

This CLI uses tests.

## Installation

Use bundler and run `$ bundle install`.

## Usage

There are two main commands in the cli and they're called `disallowed`
and `duplicates`. Each of these arguments takes a `--dry-run` option that will
print the affected rows.

Examples

```
$ ./cli.rb disallowed --dry-run
# prints all the rows in the DB that have a disallowed username

$ ./cli.rb duplicates --dry-run
# prints all the rows in the DB that are duplicate usernames

$ ./cli.rb disallowed
# this will update all disallowed usernames in the DB

$ ./cli.rb duplicates
#this will update all duplicate usernames in the DB

```

## Test

Run the tests using `rspec` command.

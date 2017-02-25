#!/bin/bash --login

# Performs integration testing against the database app
#
# Usage:
#   ./test.sh [BRANCH or COMMIT HASH]
#
# Arguments:
#  - BRANCH:      Branch in database app to checkout before starting tests
#  - COMMIT HASH: Hash of commit in database app to checkout before starting tests

# Set up testing environment variables
export PORT=3333
export API_BASE_URL=http://127.0.0.1:3333
export IS_INTEGRATION_TEST=true
export LOCAL_MAILSERVER=true

# Prepare database app
rm -rf .testdatabase
git clone https://github.com/studentorkesterfestivalen/sof-dbapp.git .testdatabase
cd .testdatabase

# Checkout optional branch or commit
if [ ! -z $1 ]
then
    git checkout $1
else
    if [ "${TRAVIS_BRANCH}" == "master" ]
    then
        git checkout master
    else
        git checkout next-release
    fi
fi

# Prepare database app
bundle install --gemfile=Gemfile
RAILS_ENV=development BUNDLE_GEMFILE=Gemfile bundle exec rake db:drop db:create db:migrate db:seed

# Ensure mailcatcher gem is installed and in separate gemset
rvm gemset create mailcatcher
rvm use 2.3.3@mailcatcher
gem install mailcatcher

# Start email server for testing
mailcatcher -f > /dev/null &
MAILCATCHER_PID=$!

# Return to previous RVM
rvm use 2.3.3

# Start database app in background a store PID
RAILS_ENV=development BUNDLE_GEMFILE=Gemfile bundle exec rails s > /dev/null &
PID=$!

# Perform test suite
cd ..
bundle exec rake test
TEST_STATUS=$?

# Stop started servers
kill ${PID}
kill ${MAILCATCHER_PID}

if [ ${TEST_STATUS} -eq 0 ];then
   exit 0
else
   exit 1
fi

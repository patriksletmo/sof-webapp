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

# Prepare database app
rm -rf .testdatabase
git clone https://github.com/studentorkesterfestivalen/sof-dbapp.git .testdatabase
cd .testdatabase

# Checkout optional branch or commit
if [ ! -z $1 ]
then
    git checkout $1
fi

# Prepare database app
bundle install
bundle exec rake db:drop db:create db:migrate

# Ensure mailcatcher gem is installed and in separate gemset
rvm gemset create mailcatcher
rvm use 2.3.3@mailcatcher
gem install mailcatcher

# Start email server for testing
mailcatcher -f &
MAILCATCHER_PID=$!

# Return to previous RVM
rvm use 2.3.3

# Start database app in background a store PID
bundle exec rails s > /dev/null &
PID=$!

# Perform test suite
cd ..
bundle exec rake test

# Stop started servers
kill ${PID}
kill ${MAILCATCHER_PID}

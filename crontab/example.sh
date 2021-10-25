#!/bin/sh

####################
## crontab syntax ##
##
##    *    *    *   *   *    command_to_executed
##    |    |    |   |   |
##    |    |    |   |   +----- day of week (0 - 6) (Sunday=0)
##    |    |    |   +------- month (1 - 12)
##    |    |    +--------- day of month (1 - 31)
##    |    +----------- hour (0 - 23)
##    +------------- min (0 - 59)
##
###########################
## fun, this is random.) ##
## 59 21 * * 1,2,3,4,5 echo "The time is 2200 hours on a weekday, sir."
#######################################################################

# editable cron tasks (VIM is default editor) --- to exit VIM, press escape, then ':q!' to quit without saving.
#$ crontab -e

# current crontab config for default user
#$ crontab -l

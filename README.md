# Robotframework template

Directory tree and scripts skeleton to quickly setup an acceptance testing suite based on [robotframework](http://www.robotframework.org) and underlying libraries

## Install on Linux (debian based)

    sudo apt-get install make python python-wxgtk2.8 python-tk
    sudo pip install -r requirements.txt

## Run!

    make acceptance-test

## Some more details

### Tests scripts naming

This skeleton test suite makes you start quickly with robotframework testing. The naming convention used is: the name of the test file is `US<Number>` where `<Number>` is the number of your User Story.

### Running tests

A makefile is provided to add some abstraction on top of the *pybot* command line utility.

To run the full test suite:

    make acceptance-test
    
To run the test scripts that have the tag `MY_TAG`

    make TAGS=MY_TAG acceptance-test
    
To run the test scripts that have the tags `MY_TAG` _and_ `MY_OTHER_TAG`:

    make TAGS=MY_TAGANDMY_OTHER_TAG acceptance-test
    
To run the test scripts on a specific target:

    make TARGET=mydev.machine acceptance-test

### Examples

Some examples are provided:

* A `01_Setup....` test which, by its name is executed first. Note for embedded developers: you can use it to deploy the new firmware on your system before running your test campain
* Some other scripts that:
 * use an example of external home-made python library
 * use the [Dialog](http://robotframework.org/robotframework/latest/libraries/Dialogs.html) (built-in) library to interact with the tester for manual testing
 * use the [SSHLibrary](https://github.com/robotframework/SSHLibrary), an external robotframework library to connect to remote hosts

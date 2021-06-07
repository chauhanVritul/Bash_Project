#! /bin/bash

# BASH script to create a bind mount of one directory to another directory
# bind mount ~/Downloads/some_Dir to ~/Documents/other_Dir

mount --bind ~/Downloads/some_Dir ~/Documents/other_Dir

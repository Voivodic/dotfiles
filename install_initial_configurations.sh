#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git is not installed. Please, install it to proceed."
    exit 1
fi

# Check if wget is installed
if ! command -v wget &> /dev/null
then
    echo "wget is not installed. Please, install it to procced."
    exit 1
fi

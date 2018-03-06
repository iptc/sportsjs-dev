#!/usr/bin/env pyth

import sys

def main():
    from os import listdir
    from os.path import isfile, join
    mypath = 'input'
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

    print onlyfiles


if __name__ == '__main__':
    main()



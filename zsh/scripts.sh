#!/bin/bash

# compress a directory
compress() {
	tar cvzf $1.tar.gz $1
}

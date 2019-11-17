#!/bin/bash

while true
do
	python3 get_view.py | tee -a get.log
	sleep 1m
done 

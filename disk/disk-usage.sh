#!/bin/bash
cd /home/;
sudo echo "-----------------" >> /home/adminit/users_profile_logs ;
sudo date >> /home/adminit/users_profile_logs ;
sudo echo "-----------------" >> /home/adminit/users_profile_logs ;
sudo du -sh  * | sort -nr >>/home/adminit/users_profile_logs;
sudo echo "-----------------" >> /home/adminit/users_profile_logs ;

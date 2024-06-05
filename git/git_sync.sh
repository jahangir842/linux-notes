#!/bin/bash

# Navigate to your Git repository
cd /home/adminit/projects/commands || { echo "Failed to navigate to repository"; exit 1; }

git pull

#!/bin/bash

source $(rospack find gnome_utilities)/scripts/rosbash.sh

confirm_restart # Start/Restart fresh roscore if the user wants.
echo "Setting use_sim_time to true..."
rosparam set use_sim_time true
#choose_a_vehicle # Get user input on which vehicle parameters to use.

args=$@
rosrun gnome_utilities generic_tabbed_terminal.py \
    --command="roslaunch vehicle_scripts desktop_bringup.launch radar_visual:=true" \
    --command="gdb --args ~/workspace/rdr/stacks/visualization/rviz/bin/rviz -d ~/workspace/rdr/stacks/visualization/rviz/rviz_configs/radar_debug.rviz" \
    --command="rosbag play $args --clock"


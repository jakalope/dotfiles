#!/bin/bash

if [ -e $(rospack find gnome_utilities)/scripts/visualize_perception.sh ]; then
  rosrun gnome_utilities visualize_perception_scoring.sh $@
else
  source $(rospack find gnome_utilities)/scripts/rosbash.sh

  if [[ "$1" == 'debug' ]]; then
      shift
      debug='debug:=true'
      pause='--pause'
  else
      debug=''
      pause=''
  fi

  bag_file="${1}"
  shift

  confirm_restart # Start/Restart fresh roscore if the user wants.
  echo "Setting use_sim_time to true..."
  rosparam set use_sim_time true
  launch_file="velodyne_lrr.launch" # set default perception launch file
  choose_a_perception_launch_file # sets variable $launch_file
  get_vehicle_id $bag_file

  args=$@
  rosrun gnome_utilities generic_tabbed_terminal.py \
      --command="ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH} roslaunch vehicle_scripts desktop_bringup.launch" \
      --command="ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH} echo '2' | ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH} rosrun rviz rviz -d ~/workspace/rdr/stacks/visualization/rviz/rviz_configs/demo.rviz" \
      --command="ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH} rosrun bag_scripts play_exclude_topics.py $bag_file $args $pause --clock --exclude PerceptionObstacles" \
      --command="ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH} roslaunch perception $launch_file $debug" 
      #--command="rosrun image_view image_view image:=/driving/svc1/right/image_raw" \
fi


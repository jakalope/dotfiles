" ~/.vim/sessions/perception_scoring_display.vim:
" Vim session script.
" Created by session.vim 2.7 on 12 November 2014 at 14:01:47.
" Open this file in Vim and run :source % to restore your session.

set guioptions=aegimrLtT
silent! set guifont=
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 0 | filetype indent off | endif
if &background != 'light'
	set background=light
endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/workspace/pjfa
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +23 ~/bin/visualize_perception_scoring.sh
badd +184 tools/perception_scoring/scripts/score.sh
badd +17 perception/ground_truth_labeler/include/ground_truth_labeler/structures/structures.h
badd +54 drivers/sensors/velodyne/src/velodyne_projector.cpp
badd +50 common/driving_common/msg_gen/cpp/include/driving_common/ProjectedSpin.h
badd +49 common/driving_common/msg_gen/cpp/include/driving_common/VelodyneRawScan.h
badd +154 perception/ground_truth_labeler/include/ground_truth_labeler/active_bag_reader.h
badd +53 common/driving_common/include/driving_common/velodyne_message_filter.h
badd +30 perception/ground_truth_labeler/include/ground_truth_labeler/common/common.h
badd +29 common/driving_common/msg_gen/cpp/include/driving_common/Obstacle.h
badd +54 common/driving_common/include/driving_common/bag_loading.h
badd +34 common/driving_common/msg_gen/cpp/include/driving_common/PerceptionObstacles.h
badd +61 common/driving_common/src/velodyne_transformer.cpp
badd +113 common/driving_common/include/driving_common/velodyne_transformer.h
badd +585 tools/perception_scoring/src/scoring_system.cpp
badd +108 perception/ground_truth_labeler/src/main.cpp
badd +243 perception/ground_truth_labeler/include/ground_truth_labeler/controller.h
badd +152 perception/ground_truth_labeler/include/ground_truth_labeler/model.h
badd +356 external/g2o/g2o_src/g2o/apps/g2o_viewer/main_window.cpp
badd +77 perception/ground_truth_labeler/include/ground_truth_labeler/obstaclesdb.h
badd +53 /opt/ros/groovy/include/ros/impl/duration.h
badd +84 tools/driving_rviz_plugins/include/driving_rviz_plugins/velodyne_display.h
badd +249 external/visualization/rviz/src/rviz/default_plugin/camera_display.cpp
badd +258 external/visualization/rviz/src/rviz/default_plugin/depth_cloud_display.cpp
badd +284 external/visualization/rviz/src/rviz/default_plugin/effort_display.cpp
badd +228 external/visualization/rviz/src/rviz/default_plugin/image_display.cpp
badd +97 external/visualization/rviz/src/rviz/default_plugin/interactive_markers/interactive_marker.cpp
badd +114 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_bld_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_blind_io.hpp
badd +99 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_cal_io.hpp
badd +101 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_dacore_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_dcom_io.hpp
badd +99 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_dsw_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_errormgr_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_fop_io.hpp
badd +97 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_lds_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_light_io.hpp
badd +103 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_ocal_io.hpp
badd +98 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_pvw_io.hpp
badd +113 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_scal_io.hpp
badd +99 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_sic_io.hpp
badd +101 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_socal_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_stramo_io.hpp
badd +79 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_test_data_io.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_tramo_io.hpp
badd +172 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_types.hpp
badd +96 external/svc2_dinx_decoder/src/interfaces/pdm_base/pdm_base_val_io.hpp
badd +89 external/svc2_dinx_decoder/src/interfaces/pdm_cfg/pdm_cfg_intmz0_jlr_io.hpp
badd +89 external/svc2_dinx_decoder/src/interfaces/pdm_cfg/pdm_cfg_intmz1_jlr_io.hpp
badd +45 external/svc2_dinx_decoder/src/interfaces/pdm_cfg/pdm_cfg_lsf_jlr_io.hpp
badd +99 external/svc2_dinx_decoder/src/interfaces/pdm_cfg/pdm_cfg_raw_jlr_io.hpp
badd +1220 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_visualizationframe_wrapper.cpp
badd +198 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_visualizationmanager_wrapper.cpp
badd +56 external/visualization/rviz/src/rviz/display.cpp
badd +52 external/visualization/rviz/src/rviz/properties/status_list.cpp
badd +95 external/visualization/rviz/src/rviz/tool.cpp
badd +214 external/visualization/rviz/src/rviz/view_controller.cpp
badd +162 external/visualization/rviz/src/rviz/visualization_frame.cpp
badd +565 external/visualization/rviz/src/rviz/visualization_manager.cpp
badd +102 external/xerces/build/xerces-c-src_2_8_0/include/xercesc/validators/datatype/DatatypeValidator.hpp
badd +37 external/xerces/build/xerces-c-src_2_8_0/include/xercesc/validators/datatype/XMLCanRepGroup.hpp
badd +102 external/xerces/build/xerces-c-src_2_8_0/src/xercesc/validators/datatype/DatatypeValidator.hpp
badd +37 external/xerces/build/xerces-c-src_2_8_0/src/xercesc/validators/datatype/XMLCanRepGroup.hpp
badd +419 tools/driving_rviz_plugins/src/perception_obstacles_display.cpp
badd +41 tools/perception_scoring/CMakeLists.txt
badd +237 tools/perception_scoring/src/perception_scoring_display.cpp
badd +36 tools/driving_rviz_plugins/include/driving_rviz_plugins/perception_obstacles_display.h
badd +410 tools/perception_scoring/include/perception_scoring/perception_scoring_display.h
badd +63 external/visualization/rviz/src/rviz/message_filter_display.h
badd +221 tools/perception_scoring/include/perception_scoring/multi_message_filter_display.h
badd +40 external/visualization/rviz/src/rviz/properties/ros_topic_property.cpp
badd +77 external/visualization/OGRE/build/OGRE/src/OGRE/RenderSystems/GLES/include/EGL/GTK/OgreGtkEGLSupport.h
badd +77 external/visualization/OGRE/build/OGRE/src/ex-OGRE1234/ogre_src_v1-7-4/RenderSystems/GLES/include/EGL/GTK/OgreGtkEGLSupport.h
badd +52 external/visualization/rviz/src/rviz/properties/ros_topic_property.h
badd +40 external/visualization/OGRE/build/OGRE/src/OGRE/Tools/MaterialEditor/MaterialEditor/src/EventContainer.cpp
badd +274 external/visualization/OGRE/build/OGRE/src/OGRE/Tools/MaterialEditor/MaterialEditor/src/WorkspacePanel.cpp
badd +561 external/visualization/rviz/src/rviz/default_plugin/effort_display.h
badd +124 external/visualization/rviz/src/rviz/default_plugin/grid_cells_display.cpp
badd +136 external/visualization/rviz/src/rviz/default_plugin/interactive_marker_display.cpp
badd +142 external/visualization/rviz/src/rviz/default_plugin/map_display.cpp
badd +49 external/visualization/rviz/src/rviz/default_plugin/marker_array_display.cpp
badd +134 external/visualization/rviz/src/rviz/default_plugin/marker_display.cpp
badd +49 tools/perception_scoring/include/scoring_system/scoring_system.h
badd +71 tools/driving_rviz_plugins/src/utilities/obstacle_visual.h
badd +3 tools/driving_rviz_plugins/src/utilities/obstacle_selection_handler.h
badd +2 tools/driving_rviz_plugins/src/utilities/polygon_object.h
badd +1 tools/driving_rviz_plugins/include/driving_rviz_plugins/property_forwards.h
badd +225 external/visualization/rviz/src/rviz/selection/selection_handler.cpp
badd +80 external/visualization/rviz/src/rviz/selection/selection_handler.h
badd +28 tools/driving_rviz_plugins/include/driving_rviz_plugins/validate_floats.h
badd +37 common/driving_common/include/driving_common/odometry_time_queue.h
badd +72 common/driving_common/include/driving_common/interpolating_time_queue.h
badd +55 supervisor/supervisor_adtf_filter/include/supervisor_adtf_type.h
badd +26 common/driving_common/include/driving_common/populated_odom_frame_obstacle.h
badd +54 external/visualization/OGRE/build/OGRE/src/OGRE/OgreMain/src/OgreRotationSpline.cpp
badd +36 common/driving_common/src/populated_odom_frame_obstacle.cpp
badd +47 tools/driving_rviz_plugins/include/utilities/obstacle_visual.h
badd +622 planning/planner/paw2/src/paw2_introspector.cpp
badd +49 external/display/include/display/display.h
badd +114 external/display/src/display.cpp
badd +48 perception/scoring_system/include/scoring_system/scoring_system.h
badd +1 common/driving_common/src/odometry_time_queue.cpp
badd +119 common/driving_common/include/driving_common/interpolating_time_queue_impl.h
badd +63 common/driving_common/include/driving_common/base_obstacle.h
badd +79 common/driving_common/src/base_obstacle.cpp
badd +38 common/driving_common/include/driving_common/populated_obstacle.h
badd +65 common/driving_common/src/populated_obstacle.cpp
badd +140 tools/driving_rviz_plugins/src/utilities/obstacle_visual.cpp
badd +187 external/visualization/rviz/src/rviz/frame_manager.cpp
badd +111 external/visualization/rviz/src/rviz/frame_manager.h
badd +820 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_boolproperty_wrapper.cpp
badd +1044 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_display_wrapper.cpp
badd +1207 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_displaygroup_wrapper.cpp
badd +790 external/visualization/rviz/build/src/python_bindings/shiboken/librviz_shiboken/rviz_property_wrapper.cpp
badd +75 external/visualization/rviz/src/rviz/default_plugin/effort_visual.cpp
badd +59 external/visualization/rviz/src/rviz/default_plugin/markers/marker_base.cpp
badd +42 external/visualization/rviz/src/rviz/default_plugin/point_visual.cpp
badd +93 external/visualization/rviz/src/rviz/default_plugin/pose_display.cpp
badd +82 common/driving_common/include/driving_common/odom_frame_obstacle.h
badd +398 common/driving_common/src/polygon.cpp
badd +53 common/driving_common/include/driving_common/polygon.h
badd +95 common/driving_common/msg_gen/cpp/include/driving_common/VehicleOdometry.h
badd +34 external/lvl/include/lvl/LineMap.h
badd +19 external/lvl/include/lvl/LineOdometry.h
badd +34 external/lvl/lvl_src/include/lvl/LineMap.h
badd +54 external/visualization/OGRE/build/OGRE/src/OGRE/OgreMain/include/OgrePose.h
badd +34 external/visualization/OGRE/build/OGRE/src/OGRE/OgreMain/src/OgrePose.cpp
badd +54 external/visualization/OGRE/build/OGRE/src/ex-OGRE1234/ogre_src_v1-7-4/OgreMain/include/OgrePose.h
badd +34 external/visualization/OGRE/build/OGRE/src/ex-OGRE1234/ogre_src_v1-7-4/OgreMain/src/OgrePose.cpp
badd +54 external/visualization/OGRE/include/OGRE/OgrePose.h
badd +87 /opt/ros/groovy/include/geometry_msgs/Pose.h
badd +41 /opt/ros/groovy/include/tf/transform_datatypes.h
badd +45 /opt/ros/groovy/include/tf/LinearMath/Transform.h
badd +19 external/lvl/lvl_src/include/lvl/LineOdometry.h
badd +124 external/visualization/OGRE/build/OGRE/src/OGRE/OgreMain/include/OgreQuaternion.h
badd +85 external/visualization/OGRE/build/OGRE/src/ex-OGRE1234/ogre_src_v1-7-4/OgreMain/include/OgreQuaternion.h
badd +85 external/visualization/OGRE/include/OGRE/OgreQuaternion.h
badd +95 /opt/ros/groovy/include/geometry_msgs/Quaternion.h
badd +31 /opt/ros/groovy/include/tf/LinearMath/Quaternion.h
badd +33 external/visualization/OGRE/build/OGRE/src/OGRE/Tools/VRMLConverter/vrmllib/include/vrmllib/nodes.h
badd +87 /opt/ros/groovy/include/geometry_msgs/Transform.h
badd +61 external/visualization/OGRE/build/OGRE/src/OGRE/OgreMain/include/OgreVector3.h
badd +21 external/visualization/OGRE/build/OGRE/src/OGRE/Tools/LightwaveConverter/include/Vector3.h
badd +51 external/visualization/OGRE/build/OGRE/src/ex-OGRE1234/ogre_src_v1-7-4/OgreMain/include/OgreVector3.h
badd +51 external/visualization/OGRE/include/OGRE/OgreVector3.h
badd +90 /opt/ros/groovy/include/geometry_msgs/Vector3.h
badd +50 /opt/ros/groovy/include/urdf_model/pose.h
badd +19 /opt/ros/groovy/include/tf/LinearMath/Matrix3x3.h
badd +277 /opt/ros/groovy/include/tf/LinearMath/Vector3.h
badd +53 tools/driving_rviz_plugins/src/utilities/horizontal_line.cpp
badd +29 tools/driving_rviz_plugins/include/utilities/polygon_object.h
badd +1 tools/driving_rviz_plugins/src/utilities/polygon_object.cpp
badd +75 ./common/driving_common/src/eigen_geometry_conversions.cpp
badd +1 common/driving_common/include/driving_common/eigen_geometry_conversions.h
badd +24 ./tools/driving_rviz_plugins/include/utilities/obstacle_selection_handler.h
badd +21 tools/driving_rviz_plugins/src/utilities/obstacle_selection_handler.cpp
badd +56 ./external/visualization/rviz/src/rviz/selection/forwards.h
args tools/driving_rviz_plugins/src/perception_obstacles_display.cpp
edit tools/perception_scoring/src/scoring_system.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 756 - ((67 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
756
normal! 02l
tabedit tools/perception_scoring/include/scoring_system/scoring_system.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 72 - ((2 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
72
normal! 0
tabedit tools/perception_scoring/include/perception_scoring/perception_scoring_display.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 313 - ((7 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
313
normal! 049l
tabedit tools/perception_scoring/src/perception_scoring_display.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 334 - ((2 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
334
normal! 012l
tabedit tools/driving_rviz_plugins/src/utilities/obstacle_visual.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 141 - ((2 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
141
normal! 0
tabedit ./tools/driving_rviz_plugins/include/utilities/obstacle_selection_handler.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 19 - ((18 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
19
normal! 06l
tabedit external/visualization/rviz/src/rviz/selection/selection_handler.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 227 - ((37 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
227
normal! 023l
tabedit common/driving_common/src/populated_odom_frame_obstacle.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 36 - ((35 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
36
normal! 02l
tabedit common/driving_common/include/driving_common/odom_frame_obstacle.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 69 - ((68 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
69
normal! 03l
tabedit common/driving_common/include/driving_common/base_obstacle.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 72 - ((2 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
72
normal! 02l
tabedit tools/perception_scoring/CMakeLists.txt
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 10 - ((9 * winheight(0) + 35) / 71)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 019l
tabnext 4
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 4
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128

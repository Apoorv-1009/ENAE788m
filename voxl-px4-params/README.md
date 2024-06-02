# PX4 Parameters


This folder contains parameter files for use with ModalAI Flight Core. Upload these via qgroundcontrol. These are NOT complete sets of PX4 parameters. These are groups of non-default parameters that are subsets of the 700+ PX4 parameters. These files are meant to be loaded over the default PX4 parameters to assist configuration.


## Platform-Specific Parameter Files

The "platforms" directory contains platform-specific parmeters such as battery, motor, and PID tuning parameters. These should be flashed over fresh px4 defaults and followed up with further configuration with the appropriate "helper" param files from the next section:



## Helper Parameter FIles


### mavlink_serial_ports.params

This is the recommended mavlink configuration for the ModalAI Flight Core.

MAV_0 is exposed on the telem1 connector at 57600 baud in 'normal' mode for SiK telemetry radios.

MAV_1 is on the telem2 connector at 921600 baud in 'onboard' mode for connection to VOXL and mavros.


### ekf2_indoor_vio.params

EKF2 config for indoor VIO Flight. Turns off use of GPS and barometerin EKF2. Still leaves these sensors on and enabled though!


### ekf2_outdoor_gps_mag.params

EKF2 config for outdoor flight with GPS, magnetomter, and Barometer, no vision!


### sensors_disable_gps_mag.params

Turns off GPS and barometer. Use this is you have no gps/mag attached or have a gps/mag attached and just want them disabled in software. Use this with ekf2_indoor_vio.params

This is not included with ekf2_indoo_vio.params since you may still want these sensors enabled for logging even when not using in EKF2.


### spektrum_dx8_config.params

Example PX4 Radio configuration for Spektrum DX8 radio. This assumes a clean acro model in the radio. You must still calibrate the radio channel ranges with qGroundControl first before loading this!

The long switch right of DX8 logo (ch 7) will be the kill switch
Up: Kill switch engaged, Down: Kill switch disengages

The 3-position switch left of dx8 logo (ch 6) will switch flight modes
Up: manual mode    Middle: Position     Down: Offboard Mode (figure eight)


### wipe_rc_cal_mapping.params

Wipes radio calibration and channel mapping. Use this when moving to a new rc radio, or to make it obvious in QGC that the radio needs to be configured.


## trim_cal_params.sh Helper Script

This is a tool to assist in backing up and transfering parameter files between drones. It is undesirable to overwrite the sensor and radio calibration parameters when loading a parameter file as this would require recalibrating afterwords. It's also undesirable to transfer the calibration parameters from one drone to another.

QGroundControl normally saves calibration values when exporting a parameter file. The trim_cal_params.sh script will remove calibration parameters from a file. Files that have been trimmed are given the "trimmed" suffix and the original file is left in place.


## collision_prevention.params

Configure collision prevention parameters to halt vehicle at 1.5m from object.

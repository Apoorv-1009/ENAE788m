#!/bin/bash
#/*****************************************************************************
# *
# * Copyright 2015-2017 Qualcomm Technologies, Inc.  All rights reserved.
# *
# * This software may be subject to U.S. and international export, re-export
# * or transfer laws. Diversion contrary to U.S. and international law is
# * strictly prohibited.
# *
# * The party receiving this software directly from QTI (the "Recipient")
# * may use this software solely as set forth in the agreement between the
# * Recipient and QTI (the "Agreement"). The software may be used in source
# * code form solely by the Recipient's employees (if any) authorized by the
# * Agreement. Unless expressly authorized in the Agreement, the Recipient
# * may not sublicense, assign, transfer or otherwise provide the source
# * code to any third party. Qualcomm Technologies, Inc. retains all
# * ownership rights in and to the software. Except as may be expressly
# * granted by the Agreement, this file provides no license to any patents,
# * trademarks, copyrights, or other intellectual property of QUALCOMM
# * Incorporated or its affiliates.
# *
# * This notice supersedes any other QTI notices contained within the
# * software except copyright notices indicating different years of
# * publication for different portions of the software. This notice does not
# * supersede the application of any third party copyright notice to that
# * third party's code.
# ****************************************************************************/

FILE=$1

if [ -z "$FILE" ]; then
    echo "please provide a filename as an argument"
    exit 1
fi

NEWFILE="${FILE%.params}_trimmed.params"

echo ""
echo "about to trim calibration parameters from file: ${FILE}"
echo "this will create a new file ${NEWFILE}"
echo "press any key to continue or ctrl-c to quit"
echo ""
read n

## duplicate file, never modify old one!!
cp ${FILE} ${NEWFILE}

SED="sed -i"

# Sensor Cal
$SED '/CAL_\(.*\)/d' $NEWFILE
$SED '/EKF2_MAGBIAS_/d' $NEWFILE
$SED '/EKF2_MAG_DECL/d' $NEWFILE
$SED '/SENS_BOARD_\(.*\)_OFF/d' $NEWFILE

# all thermal compensation values, including the enable flags
$SED '/	TC_/d' $NEWFILE

# some people won't use mag
$SED '/SYS_HAS_MAG/d' $NEWFILE

# board rotation is specific to install
$SED '/SENS_BOARD_ROT/d' $NEWFILE

# RC Cal
$SED '/	RC/d' $NEWFILE
$SED '/COM_FLTMODE/d' $NEWFILE


# Dynamic values that shouldn't be parameters
$SED '/COM_FLIGHT_UUID/d' $NEWFILE
$SED '/LND_FLIGHT_T_HI/d' $NEWFILE
$SED '/LND_FLIGHT_T_LO/d' $NEWFILE

# Remove SYS_ID, no need to wipe this
$SED '/MAV_SYS_ID/d' $NEWFILE


$SED '/COM_MOT_TEST_EN/d' $NEWFILE
$SED '/SYS_RESTART_TYPE/d' $NEWFILE

echo "DONE"

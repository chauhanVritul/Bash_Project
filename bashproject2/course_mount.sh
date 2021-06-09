#!/bin/bash
#
#BASH script to mount directory as different user
#Usage:
#	./course_mount.sh -h To print this help message
#	./course_mount.sh -m -c [course] For mounting a given course
#	./course_mount.sh -u -c [course] For unmounting a given course
#	If course name is ommited all courses will be (un)mounted
COURSE_PATH='/home/user1/myDir/bashproject2/data/courses/'
TARGET_PATH='/home/user1/myDir/bashproject2/trainee'
courses=(
"linux_course/linux_course_1"
"linux_course/linux_course_2"
"machinelearning/machinelearning1"
"machinelearning/machinelearning2"
"machinelearning/machinelearning3"
)
usage()
{
	echo 'Usage:'
        echo -e '\t' ./course_mount.sh -h To print this help message
        echo -e '\t' ./course_mount.sh -m -c '[course]' For mounting a given course
        echo -e '\t' ./course_mount.sh -u -c '[course]' For unmounting a given course 
        echo If course name is ommited all courses will be '(un)'mounted

}

check_mount()
{	
	CHECK_PATH=$TARGET_PATH/$(echo $1 | awk -F '/' '{print $2}')
	if grep -qs $CHECK_PATH /proc/mounts; then
		IS_MNT=0
	else
		IS_MNT=1
	fi
	echo $IS_MNT
}

mount_course()
{
	dir=$1
        if [ -z $dir ]; then mount_all ;
        elif [[ ${courses[*]} =~ $dir ]]; then
		MOUNT_STATUS=$(check_mount $dir)
		cd $TARGET_PATH
		if [ 0 -eq $MOUNT_STATUS ]
		then 
			echo Mount already exists
		else
			newfilepath=$(echo $dir | awk -F '/' '{print $2}')
			echo mounting course: $newfilepath at $TARGET_PATH/$newfilepath
			mkdir -p $newfilepath
			bindfs -p a-w -u user1 -g ftpaccess $COURSE_PATH$dir/ $TARGET_PATH/$newfilepath
		fi
        else
                echo Course not found
        fi
}
mount_all()
{
	for crs in ${courses[*]}
	do
		mount_course $crs
	done
	
}
unmount_course()
{
	dir=$1
	if [ -z $dir ]; then unmount_all ;
	elif [[ ${courses[*]} =~ $dir ]]; then
		MOUNT_STATUS=$(check_mount $dir)
		if [ 0 -eq $MOUNT_STATUS  ]
		then
			newfilepath=$(echo $dir | awk -F '/' '{print $2}')
			umount $TARGET_PATH/$newfilepath
			echo Unmounted $newfilepath
			rm -r $TARGET_PATH/$newfilepath
		else
			echo Mount doesnt exists
		fi
	else
		echo Course not found
	fi
}
unmount_all()
{
	for crs in ${courses[*]}
        do
                unmount_course $crs
        done

}
#[[ ${courses[*]} =~ 'machinelearning/machinelearning1' ]] && echo 'yes' || echo 'no' 
while getopts ":hm:u:" opts
do
	case "$opts" in
	h)	usage ;;
	m)	dir=$OPTARG
		if [ $dir = '-c' ]; then
			mount_course $3
		else
			echo Invalid Argument
		fi
		;;
	u)	dir=$OPTARG
                if [ $dir = '-c' ]; then
                        unmount_course $3
                else
                        echo Invalid Argument
                fi
                ;;
	:)	dir=$OPTARG
		if [ $dir = "m" ]; then
			mount_all
		else
			unmount_all
		fi ;;
	\?)	echo usage: '[-h]' '[-m]' '[-c] (optional)' '[course name] (optional)';;
	esac
done


# `raid_localssd`

`raid_localssd` is the Ansible role to install the script and its corresponding systemd unit that scans local NVMe SSD disks and sets them up as a single RAID0 array. Best suited for use in Google Cloud setups.

### Notes

* The final array is mounted to `/mnt/local` by default. This can be overridden with the `cikube_raid_localssd_mount' variable

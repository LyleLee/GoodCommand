# coding=utf-8
# !/bin/env python3
import sys
import json
import time
import os
import csv

parent_dir = os.path.abspath(sys.argv[1])


def get_fio_result(json_file):
    cmd = "fio"
    fio_result = {}

    with open(json_file, 'r') as json_fd:
        try:
            one_file_dict = json.load(json_fd)
        except ValueError:
            print(f"error: {json_file}")
            return False
        fio_result['host_name'] = os.path.basename(json_file).split('-')[0]
        for option in one_file_dict['global options']:
            # print(option, ":", one_file_dict['global options'][option])
            fio_result[option] = one_file_dict['global options'][option]
        fio_result['numjobs'] = len(one_file_dict['jobs'])
        rw = one_file_dict['global options']['rw']
        if rw == 'randread':
            rw = 'read'
        if rw == 'randwrite':
            rw = 'write'

        fio_result['bw_KiB'] = 0
        fio_result['iops'] = 0
        fio_result['lat_ns_mean'] = 0
        fio_result['lat_ns_max'] = 0
        for one_job in one_file_dict['jobs']:
            fio_result['bw_KiB'] += one_job[rw]['bw']
            fio_result['iops'] += one_job[rw]['iops']
            fio_result['lat_ns_mean'] += one_job[rw]['lat_ns']['mean']
            fio_result['lat_ns_max'] = one_job[rw]['lat_ns']['max'] if one_job[rw]['lat_ns']['max'] >= fio_result['lat_ns_max'] else fio_result['lat_ns_max']
        fio_result['lat_ns_mean'] = fio_result['lat_ns_mean']/fio_result['numjobs']
    return fio_result


def processing(dir_name):
    fio_csv = os.path.join(parent_dir, os.path.basename(parent_dir)+".csv")
    with open(fio_csv, 'w', newline='') as f:
        csv_write = csv.writer(f)
        head_line = []
        data_line = []
        for current_dir, sub_dirs, files in os.walk(dir_name):
            for one_file in files:
                if one_file.endswith(".json"):
                    one_file_full_path = os.path.join(current_dir, one_file)
                    fio_result = get_fio_result(one_file_full_path)
                    one_head_line = fio_result.keys()
                    one_data_line = fio_result.values()
                    if len(head_line) == 0:
                        head_line = one_head_line
                        csv_write.writerow(head_line)
                    if head_line == one_head_line:
                        csv_write.writerow(one_data_line)
                    else:
                        print(f"head line not the same: \n")
                        print(f"head line before: {data_line} \n head line this file {one_head_line}")
    f.close()


processing(parent_dir)

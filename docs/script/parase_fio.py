# coding=utf-8
# !/bin/env python3
import sys
import json
import time
import os
import csv

parent_dir = os.path.abspath(sys.argv[1])


def get_json_result(json_file):
    cmd = "fio"
    with open(json_file, 'r') as json_fd:
        try:
            one_file_dict = json.load(json_fd)
        except ValueError:
            print(f"error: {json_file}")
            return ["", "", "", "", "", "", "", "", "", "", "", "", ""]
        # generate command line
        for option in one_file_dict['global options']:
            # print(option, ":", one_file_dict['global options'][option])
            cmd = cmd+" -"+option+"=" + one_file_dict['global options'][option]
        for job_option in one_file_dict['jobs'][0]['job options']:
            cmd = cmd+" -"+job_option+"="+one_file_dict['jobs'][0]['job options'][job_option]
        # get result
        host_name = os.path.basename(json_file).split('-')[0]
        rbd_name = one_file_dict['global options']['rbdname']
        bs = one_file_dict['global options']['bs']
        rw = one_file_dict['global options']['rw']
        ioengine = one_file_dict['global options']['ioengine']
        iodirect = one_file_dict['global options']['direct']  if 'direct' in one_file_dict['global options'] else 0
        iodepth = one_file_dict['global options']['iodepth']
        number_job = len(one_file_dict['jobs'])
        if rw.find('write') == -1:
            bw = one_file_dict['jobs'][0]['read']['bw']
            iops = one_file_dict['jobs'][0]['read']['iops']
            lat_mean_ms = one_file_dict['jobs'][0]['read']['lat_ns']['mean']/1000000
            lat_max_ms = one_file_dict['jobs'][0]['read']['lat_ns']['max']/1000000
        else:
            bw = one_file_dict['jobs'][0]['write']['bw']
            iops = one_file_dict['jobs'][0]['write']['iops']
            lat_mean_ms = one_file_dict['jobs'][0]['write']['lat_ns']['mean']/1000000
            lat_max_ms = one_file_dict['jobs'][0]['write']['lat_ns']['max']/1000000
        return [host_name, rbd_name, bs, rw, ioengine, iodirect, iodepth, number_job, iops, bw,
                lat_mean_ms, lat_max_ms, cmd]


def processing(dir_name):
    fio_csv = os.path.join(parent_dir, os.path.basename(parent_dir)+".csv")
    with open(fio_csv, 'w', newline='') as f:
        csv_write = csv.writer(f)
        csv_write.writerow(["host_name", "rbd_name", "bs", "rw", "ioengine", "iodirect", "iodepth", "number_job",
                            "iops", "bw_KiB", "lat_mean_ms", "lat_max_ms", "cmd"])
        for current_dir, sub_dirs, files in os.walk(dir_name):
            for one_file in files:
                if one_file.endswith(".json"):
                    data_line = get_json_result(os.path.join(current_dir, one_file))
                    if data_line[0]:
                        csv_write.writerow(data_line)
    f.close()


processing(parent_dir)

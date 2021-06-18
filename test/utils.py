#!/usr/bin/env python
import docker
import sys
import time
import io
import tarfile
import shutil
import os
import yaml

class DockerUtil():
    @classmethod
    def generate_compose_yml(cls, destfile, image, yaml_file='test.yml'):
        # generate yml file used test scenario3
        with open(os.path.join('.', 'testdata', yaml_file), 'r') as f:
            data = yaml.safe_load(f)
        
        # modify the Connect image in the yml data
        data['services']['mc']['image'] = image

        # write to destination file, expect full path to file
        with open(destfile,'w') as f:
            yaml.dump(data, f, default_flow_style=False)

    @classmethod
    def found_log_message(cls, container, message):
        # find a message in the container log
        logs = container.logs()
        if logs.find(message) != -1:
            return True
        return False

    @classmethod
    def wait_for_log_message(cls, containers, message, timeout):
        # wait a max of <timeout> for log message to appear within <container>
        for container in containers:
            while not cls.found_log_message(container, message):
                timeout -= 1
                time.sleep(1)
                if timeout == 0:
                    raise Exception("Reached timeout, waiting for log message")

    @classmethod
    def wait_for_containers(cls, containers, timeout):
        # wait a max of <timeout> for MC to start within <container>
        for container in containers:
            # look for "Web server running" line in container log
            while not cls.found_log_message(container, "Web server running"):
                timeout -= 1
                time.sleep(1)
                if timeout == 0:
                    raise Exception("Reached timeout, waiting for Connect to come up")

    @classmethod
    def check_container_log(cls, container, phrase):
        # look for string in container log
        logs = container.logs()
        if logs.find(phrase) != -1:
            return True
        return False

    @classmethod
    def get_prop_file_as_map(cls, container, path):
        # retrieve file from container,return value as hash/map 
        mp = io.BytesIO()
        bits, stat = container.get_archive(path)
        for chunk in bits:
            mp.write(chunk)
        mp.seek(0)
        tar = tarfile.open(fileobj=mp)
        member = tar.getmembers()[0]
        content = tar.extractfile(member)
        props = {}
        for line in content:
            l = line.strip()
            if l and not l.startswith("#"):
                key_value = l.split("=")
                key = key_value[0].strip()
                value = "=".join(key_value[1:]).strip().strip('"')
                props[key] = value
        tar.close()
        mp.close()
        return props

    @classmethod
    def get_file_as_string_array(cls, container, path):
        # retrieve file from container, return as string array
        mp = io.BytesIO()
        bits, stat = container.get_archive(path)
        for chunk in bits:
            mp.write(chunk)
        mp.seek(0)
        tar = tarfile.open(fileobj=mp)
        member = tar.getmembers()[0]
        content = tar.extractfile(member)
        array = []
        for line in content:
            l = line.strip()
            if l and not l.startswith("#"):
                array.append(l)
        tar.close()
        mp.close()
        return array

    @classmethod
    def get_file_as_string(cls, container, path):
        # retrieve file from container, return as string
        mp = io.BytesIO()
        bits, stat = container.get_archive(path)
        for chunk in bits:
            mp.write(chunk)
        mp.seek(0)
        tar = tarfile.open(fileobj=mp)
        member = tar.getmembers()[0]
        content = tar.extractfile(member)
        string_content = content.read()
        tar.close()
        mp.close()
        return string_content

    @classmethod
    def dump_file(cls, container, docker_path, local_path):
        # retrieve file from cintainer, write to file on local
        mp = io.BytesIO()
        bits, stat = container.get_archive(docker_path)
        for chunk in bits:
            mp.write(chunk)
        mp.seek(0)
        tar = tarfile.open(fileobj=mp)
        tar.extractall(path=local_path, members=None)
        tar.close()
        mp.close()

    @classmethod
    def list_container_dir(cls, container, docker_path):
        # retrieve dir from cintainer, return dir listing 
        mp = io.BytesIO()
        bits, stat = container.get_archive(docker_path)
        for chunk in bits:
            mp.write(chunk)
        mp.seek(0)
        dir_tar = tarfile.open(fileobj=mp)
        dir_list = dir_tar.getnames()
        dir_tar.close()
        mp.close()
        return dir_list

    @classmethod
    def empty_test_folder(cls, name):
        # empty test folder on local host
        local_path = os.path.join(os.getcwd(), name , '') 
        if os.path.isdir(local_path):
            shutil.rmtree(local_path)
    
    @classmethod
    def create_test_dir(cls, name):
        # create test folder on local host
        local_path = os.path.join(os.getcwd(), name , '') 
        directory = os.path.dirname(local_path)
        print("Create test directory at " + local_path)
        if not os.path.exists(directory):
            os.makedirs(directory)
        return local_path

    @classmethod
    def list_test_dir(cls, name):
        # list directory content on local host
        local_path = os.path.join(os.getcwd(), name , '')  
        dirs = os.listdir(local_path)
        return dirs

    

#!/usr/bin/env python
import docker
import unittest
from utils import DockerUtil

""" 
SCENARIO 2 
Docker run with -v to mount volume but no extensiosn
    Verify MC start up properly
    Verify appdata is populated with data
"""

class DockerTests2(unittest.TestCase):
    docker_image = ""
    container = ""

    @classmethod
    def setUpClass(cls):
        print(' \n >>>> ==== Running Test 2 - Verify Mounted Volume')
        print(' >>>> ==== using IMAGE = ' + cls.docker_image + ' ===== ')
        DockerUtil.empty_test_folder("tmp")
        # Setup test dir as volume to by mounted by container
        appdata = DockerUtil.create_test_dir("tmp/appdata")
        exts =  DockerUtil.create_test_dir("tmp/extensions")
        mount={}
        mount[appdata]= { 'bind':'/opt/connect/appdata', 'mode':'rw'}
        mount[exts]= {'bind':'/opt/connect/custom-extensions','mode':'ro'}
        # run docker image with -v option
        client = docker.from_env()
        cls.container = client.containers.run(cls.docker_image,volumes=mount,detach=True,name="mctest2")
        # wait for MC to come up
        try:
            DockerUtil.wait_for_containers([cls.container], 60)
        except Exception, e:
            print(">>>> MC server failed to start")
            cls.tearDownClass()
            raise e

    def test_mounted_appdata(self):
        # Verify appdata is populated with files
        count = len(DockerUtil.list_test_dir("tmp/appdata/"))
        self.assertGreaterEqual(5, count)

    @classmethod
    def tearDownClass(cls):
        # clean up at the end of the test
        cls.container.stop()
        cls.container.remove()
        DockerUtil.empty_test_folder("tmp") 
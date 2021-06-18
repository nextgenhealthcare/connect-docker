#!/usr/bin/env python
import docker
import os
import unittest
from utils import DockerUtil

"""
SCENARIO - downloading Connect keystore
    Verify keystore download over HTTP
"""
class DockerTestsKeystoreHTTP(unittest.TestCase):
    docker_image = ""
    container = ""
    test_yml = os.path.join('.','tmp','keystore-http.yml')
    composeCmd = 'docker-compose -f '+ test_yml +' -p mctest_keystore_http'
    max_wait_time = 20

    @classmethod
    def setUpClass(cls):
        print(' \n >>>> ==== Running Test Keystore - Verify Compose with keystore download HTTP' + ' ===== ') 
        print( ' >>>> ==== using IMAGE = ' + cls.docker_image + ' ===== ')
        DockerUtil.empty_test_folder("tmp")

        # Setup test dir as volume to by mounted by container
        if os.name == 'nt':
            DockerUtil.create_test_dir("tmp")
            os.system('xcopy /E /I /Y .\\testdata\\web .\\tmp\\web')
        else:
            DockerUtil.create_test_dir("tmp")
            os.system('cp -r ./testdata/web ./tmp/web')
        DockerUtil.generate_compose_yml(cls.test_yml, cls.docker_image, 'keystore-http.yml')
        
        # Run docker compose
        os.system(cls.composeCmd + " up -d")
        client = docker.from_env()
        cls.container = client.containers.get("mctest_keystore_http_mc_1")

    def test_keystore_http(self):
        # HTTP download

        # expect to find downloading keystore message
        # expect to see Connect start
        try:
            # wait for keystore download message
            DockerUtil.wait_for_log_message([self.container], "Downloading keystore at", self.max_wait_time)

            # wait for MC to come up
            DockerUtil.wait_for_containers([self.container], self.max_wait_time)
        except Exception as e:
            # fail if there is any exception
            self.fail(e)

    @classmethod
    def tearDownClass(cls):
        # clean up at the end of the test
        os.system(cls.composeCmd + " down")
        DockerUtil.empty_test_folder("tmp")

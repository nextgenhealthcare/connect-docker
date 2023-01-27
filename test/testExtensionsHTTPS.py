#!/usr/bin/env python
import docker
import os
import unittest
from utils import DockerUtil

"""
SCENARIO - downloading Connect extensions in to extensions folder
    Verify extensions download over HTTPS, self-signed cert fails
"""
class DockerTestsExtensionsHTTPS(unittest.TestCase):
    docker_image = ""
    container = ""
    test_yml = os.path.join('.','tmp','extensions-https.yml')
    composeCmd = 'docker-compose -f '+ test_yml +' -p mctest_extensions_https'
    max_wait_time = 120

    @classmethod
    def setUpClass(cls):
        print(' \n >>>> ==== Running Test extensions - Verify extensions download HTTPS' + ' ===== ') 
        print( ' >>>> ==== using IMAGE = ' + cls.docker_image + ' ===== ')
        DockerUtil.empty_test_folder("tmp")

        # Setup test dir as volume to by mounted by container
        if os.name == 'nt':
            DockerUtil.create_test_dir("tmp")
            os.system('xcopy /E /I /Y .\\testdata\\web .\\tmp\\web')
        else:
            DockerUtil.create_test_dir("tmp")
            os.system('cp -r ./testdata/web ./tmp/web')
        DockerUtil.generate_compose_yml(cls.test_yml, cls.docker_image, 'extensions-https.yml')
        
        # Run docker compose
        os.system(cls.composeCmd + " up -d")
        client = docker.from_env()
        cls.container = client.containers.get("mctest_extensions_https-mc-1")

    def test_extensions_https(self):
        # HTTPS but not allowing insecure

        # expect to find downloading extensions in to folder
        # expect to find SSL cert problem
        try:
            DockerUtil.wait_for_log_message([self.container], "Downloading extensions at", self.max_wait_time)
            DockerUtil.wait_for_one_of_log_messages([self.container], ["SSL certificate problem: self signed certificate", "SSL certificate problem: self-signed certificate"], self.max_wait_time)
        except Exception as e:
            self.fail(e)
        
        # expect Connect to not start
        try:
            DockerUtil.wait_for_containers([self.container], self.max_wait_time)
        except Exception as e:
            self.fail(e)

    @classmethod
    def tearDownClass(cls):
        # clean up at the end of the test
        os.system(cls.composeCmd + " down")
        DockerUtil.empty_test_folder("tmp")

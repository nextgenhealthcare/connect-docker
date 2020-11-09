#!/usr/bin/env python
import docker
import unittest
from utils import DockerUtil

"""
SCENARIO 1
Docker run with -e for 2 or more entries from mirth.properties & vmoptions
    Verify mirth.properties entry
    Verify vmoption entry
"""

class DockerTests1(unittest.TestCase):
    docker_image = ""
    container = ""
    mirth_properties_map = {}
    vmoptions_array = []
    max_wait_time = 240

    @classmethod
    def setUpClass(cls):
        # run docker image with 2 environment variables
        print(' \n >>>> ==== Running Test 1 - Verify Environment Variables' + ' ===== ')
        print(' >>>> ==== using IMAGE = ' + cls.docker_image + ' ===== ')
        client = docker.from_env()
        cls.container = client.containers.run(cls.docker_image, 
            environment=[
                "SESSION_STORE=true",
                "VMOPTIONS=-Xmx768m"
            ],
            detach=True, 
            name="mctest1")
        # wait for MC to come up
        try:
            DockerUtil.wait_for_containers([cls.container], cls.max_wait_time)
        except Exception, e:
            print(">>>> MC server failed to start")
            cls.tearDownClass()
            raise e
        # retrieve container mirth.properties file as a map
        cls.mirth_properties_map = DockerUtil.get_prop_file_as_map(cls.container, "/opt/connect/conf/mirth.properties")
        # retrieve container server.vmoptions file as string array
        cls.vmoptions_array = DockerUtil.get_file_as_string_array(cls.container, "/opt/connect/mcserver.vmoptions")

    def test_env_mirth_properties(self):
        # Verify mirth.properties entry from environment variable
        props = self.__class__.mirth_properties_map
        self.assertEqual("true", props.get("server.api.sessionstore"))

    def test_env_vmoptions(self):
        # Verify vmoption entry from environment variable
        vmoptions = self.__class__.vmoptions_array
        last_item = vmoptions[-1]
        self.assertEqual("-Xmx768m", last_item)

    @classmethod
    def tearDownClass(cls):
        # clean up at the end of the test
        cls.container.stop()
        cls.container.remove() 
        cls.mirth_properties_map = {}
        cls.vmoptions_array = []

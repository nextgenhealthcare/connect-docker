#!/usr/bin/env python
import docker
import os
import unittest
from utils import DockerUtil

"""
SCENARIO 3 - using docker-compose
using secret to input license key,database username/password, keystore/keypass
    Verify keystore in mirth.properties
    Verify extensions - plugin.xml are in container /opt/connect/extensions/testExtension1,2,3
    Verify containers running with server started and postgres db
"""
class DockerTests3(unittest.TestCase):
    docker_image = ""
    container = ""
    mirth_properties_map = {}
    extensions_list = []
    composeCmd = 'docker-compose -f ./tmp/test.yml -p mctest3'
    max_wait_time = 240

    @classmethod
    def setUpClass(cls):
        print(' \n >>>> ==== Running Test 3 - Verify Compose with secret, postgres, custom-extensions' + ' ===== ') 
        print( ' >>>> ==== using IMAGE = ' + cls.docker_image + ' ===== ')
        DockerUtil.empty_test_folder("tmp")
        # Setup test dir as volume to by mounted by container
        exts =  DockerUtil.create_test_dir("tmp/exts")
        os.system('cp ./testdata/*.zip ./tmp/exts/')
        os.system('cp ./testdata/secret.properties ./tmp/')
        DockerUtil.generate_compose_yml('./tmp/test.yml',cls.docker_image)
        # Run docker compose        
        os.system(cls.composeCmd + " up -d")
        client = docker.from_env()
        cls.container = client.containers.get("mctest3_mc_1")
        # wait for MC to come up
        try:
            DockerUtil.wait_for_containers([cls.container], cls.max_wait_time)
        except Exception, e:
            print(">>>> MC server failed to start")
            cls.tearDownClass()
            raise e
        # retrieve container mirth.properties file as a map
        cls.mirth_properties_map = DockerUtil.get_prop_file_as_map(cls.container, "/opt/connect/conf/mirth.properties")
        # retrieve container extensions folder 
        cls.extensions_list = DockerUtil.list_container_dir(cls.container,"/opt/connect/extensions/")

    def test_secret_keystore(self):
        # Verify mirth.properties entry from environment variable
        props = self.__class__.mirth_properties_map
        self.assertEqual("dockertest", props.get("keystore.storepass"))

    def test_mirthdb_postgres(self):
        # Verify MC started up with postgres
        self.assertTrue(DockerUtil.check_container_log(self.__class__.container,"postgres"))    

    # REMOVE IF NOT USING EXTENSIONS
    def test_custom_extensions(self):
        # Verify plugin.xml file for each test Extensions in MC extensions folder
        exts = self.__class__.extensions_list
        self.assertTrue(("extensions/testExtension3/plugin.xml" in exts) and ("extensions/testExtension2/plugin.xml" in exts) and ("extensions/testExtension1/plugin.xml" in exts))

    # REMOVE IF NOT USING LICENSE KEY
    # def test_license_key_activation(self):
    #     # Verify MC started with license key activation
    #     self.assertTrue(DockerUtil.check_container_log(self.__class__.container,"Activated a new machine"))

    @classmethod
    def tearDownClass(cls):
        # clean up at the end of the test
        os.system(cls.composeCmd + " down")
        DockerUtil.empty_test_folder("tmp")
        cls.mirth_properties_map = {}
        cls.extensions_list = []

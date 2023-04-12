#!/usr/bin/env python
import docker
import unittest
import argparse
import platform
from utils import DockerUtil
from test1 import DockerTests1
from test2 import DockerTests2
from test3 import DockerTests3
from testKeystoreHTTP import DockerTestsKeystoreHTTP
from testKeystoreHTTPS import DockerTestsKeystoreHTTPS
from testKeystoreHTTPSInsecure import DockerTestsKeystoreHTTPSInsecure
from testCustomJarsHTTP import DockerTestsCustomJarsHTTP
from testCustomJarsHTTPS import DockerTestsCustomJarsHTTPS
from testCustomJarsHTTPSInsecure import DockerTestsCustomJarsHTTPSInsecure
from testExtensionsHTTP import DockerTestsExtensionsHTTP
from testExtensionsHTTPS import DockerTestsExtensionsHTTPS
from testExtensionsHTTPSInsecure import DockerTestsExtensionsHTTPSInsecure

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--image", dest="image", help="docker image name (default: nextgenhealthcare/connect)", required=False)
    parser.add_argument("-t", "--tag", dest="tag", help="docker image tag (default: latest)", required=False)
    args = parser.parse_args()
    image = args.image
    tag = args.tag
    tags = [tag]
    if (not image) and (not tag):
        # without any argument, will run for all latest JRE images
        image = "nextgenhealthcare/connect"
        tags = ["latest", "latest-jdk", "latest-zulu-alpine", "latest-zulu-alpine-jdk"]
    elif not image: 
        image = "nextgenhealthcare/connect"
    elif not tag:
        tags = ["latest"]

    test_classes = [DockerTests1, DockerTests2, DockerTests3, DockerTestsKeystoreHTTP, DockerTestsKeystoreHTTPS, DockerTestsKeystoreHTTPSInsecure, DockerTestsCustomJarsHTTP, DockerTestsCustomJarsHTTPS, DockerTestsCustomJarsHTTPSInsecure,DockerTestsExtensionsHTTP, DockerTestsExtensionsHTTPS, DockerTestsExtensionsHTTPSInsecure]
    loader = unittest.TestLoader()

    for itag in tags:
        suite = unittest.TestSuite()
        docker_image = image + ":" + itag
        for c in test_classes:
            c.docker_image = docker_image
            suite.addTests(loader.loadTestsFromTestCase(c))
        runner = unittest.TextTestRunner(verbosity=2)
        runner.run(suite)


if __name__ == "__main__":
    main()

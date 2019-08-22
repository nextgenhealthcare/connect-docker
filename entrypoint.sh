#!/bin/bash

chown -R mirth /opt/connect/appdata
exec gosu mirth "$@"
#!/bin/bash
### insert path to java 1.8 installation
#export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64/"

cd src/main/python || echo "python sources not found"
source venv/bin/activate
python3 -m main
python3 -m plotting
deactivate

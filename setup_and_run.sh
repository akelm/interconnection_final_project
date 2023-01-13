#!/bin/bash
### insert path to java 1.8 installation
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64/"


PATH=$JAVA_HOME:$PATH
mvn clean
mvn package
cd src/main/python || echo "python sources not found"
if [[ -d venv ]]; then
  source venv/bin/activate
else
  python3 -m venv venv;
  source venv/bin/activate
  pip3 install -r requirements.txt
fi
python3 -m main
python3 -m plotting


[[ -d venv ]] || python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/
export JVM_PATH=/usr/lib/jvm/java-8-openjdk/jre/lib/amd64/server/libjvm.so

python3 -m main
python3 -m plotting
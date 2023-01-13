[[ -d venv ]] || python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/ python3 -m main
python3 -m plotting
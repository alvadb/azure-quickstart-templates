touch buildDockerWAR.sh

#!/bin/bash
echo '#!/bin/bash' >> buildDockerWAR.sh
echo "dockerName=\${1//.}" >> buildDockerWAR.sh
echo "dockerName=\`echo \"\$dockerName\" | tr '[:upper:]' '[:lower:]'\`" >> buildDockerWAR.sh
echo "docker rm  \$(docker stop \$(docker ps -a -q --filter ancestor=easydeploy/\$dockerName --format=\"{{.ID}}\"))" >> buildDockerWAR.sh
echo "mkdir \$dockerName" >> buildDockerWAR.sh
echo "rm \$1" >> buildDockerWAR.sh
echo "cp ../\$1 ." >> buildDockerWAR.sh
echo "rm Dockerfile" >> buildDockerWAR.sh
echo "touch Dockerfile" >> buildDockerWAR.sh
echo "echo \"FROM tomcat:8.0.20-jre8\" >> Dockerfile" >> buildDockerWAR.sh
echo "echo \"COPY /$1 /usr/local/tomcat/webapps/\$1\" >> Dockerfile" >> buildDockerWAR.sh
echo "docker build -t easydeploy/\$dockerName ." >> buildDockerWAR.sh
echo "docker run -it -d -p \$2:8080 easydeploy/\$dockerName" >> buildDockerWAR.sh

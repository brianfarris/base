docker run --hostname docker -v /etc/localtime:/etc/localtime:ro -v ~/.ssh:/root/.ssh -it --rm -p 8888:8888 -v $(pwd)/src:/src bfarris/base:v1 /bin/bash

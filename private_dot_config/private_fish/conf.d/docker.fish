function dubuntu
  docker run --rm -it ubuntu:20.04 /bin/bash
end

function ddebian
  docker run --rm -it debian:stretch /bin/bash
end

function dalpine
  docker run --rm -it alpine /bin/ash
end

function toolkit
  docker run --rm -it hapana/toolkit /bin/ash
end

function dcleanup
  docker stop (docker ps -aq)
  docker rm (docker ps -qa)
  docker rmi (docker images -aq)
end

set -gx DOCKER_DEFAULT_PLATFORM linux/amd64

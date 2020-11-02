dubuntu (){
  docker run --rm -it ubuntu:20.04 /bin/bash
}

ddebian (){
  docker run --rm -it debian:stretch /bin/bash
}

dalpine (){
  docker run --rm -it alpine /bin/ash
}

toolkit (){
  docker run --rm -it hapana/toolkit /bin/ash
}

dcleanup (){
  docker stop $(docker ps -aq)
}

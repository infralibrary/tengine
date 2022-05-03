#!/bin/bash

tag="2.3.3"
DOCKER_REGISTRY_URL="docker.io"
ALIYUN_REGISTRY_URL="registry.cn-hangzhou.aliyuncs.com"

docker system prune -a -f

docker build --no-cache --file mainline/alpine3.12/Dockerfile \
        -t ${DOCKER_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine3.12 \
        -t ${ALIYUN_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine3.12 .

docker build --no-cache --file mainline/alpine3.14/Dockerfile \
        -t ${DOCKER_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine3.14 \
        -t ${DOCKER_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine \
        -t ${DOCKER_REGISTRY_URL}/infralibrary/tengine:${tag} \
        -t ${DOCKER_REGISTRY_URL}/infralibrary/tengine:latest \
        -t ${ALIYUN_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine3.14 \
        -t ${ALIYUN_REGISTRY_URL}/infralibrary/tengine:${tag}-alpine \
        -t ${ALIYUN_REGISTRY_URL}/infralibrary/tengine:${tag} \
        -t ${ALIYUN_REGISTRY_URL}/infralibrary/tengine:latest .


docker images


for reg in ${DOCKER_REGISTRY_URL} ${ALIYUN_REGISTRY_URL};
do
    docker push ${reg}/infralibrary/tengine:${tag}-alpine3.12
    docker push ${reg}/infralibrary/tengine:${tag}-alpine3.14
    docker push ${reg}/infralibrary/tengine:${tag}-alpine
    docker push ${reg}/infralibrary/tengine:${tag}
    docker push ${reg}/infralibrary/tengine:latest
done



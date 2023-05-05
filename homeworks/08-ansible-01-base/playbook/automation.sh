#!/usr/bin/env bash
echo "Starting docker containers"
docker run -dt --name ubuntu  pycontribs/ubuntu && echo "ubuntu started"
docker run -dt --name centos7  pycontribs/centos:7 && echo "ubuntu started"
docker run -dt --name fedora  pycontribs/fedora && echo "ubuntu started"
echo "Lets Play"
ansible-playbook -i inventory/prod.yml site.yml --vault-password-file ansible_vault
echo "Stopping and remove containers"
docker stop centos7 && docker rm centos7
docker stop ubuntu && docker rm ubuntu
docker stop fedora && docker rm fedora
# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule: `pip3 install "molecule==3.5.2"`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.

```shell
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/clickhouse$ molecule test -s centos_7
---
dependency:
  name: galaxy
driver:
  name: docker
  options:
    D: true
    vv: true
lint: 'yamllint .

  ansible-lint

  flake8

  '
platforms:
  - capabilities:
      - SYS_ADMIN
    command: /usr/sbin/init
    dockerfile: ../resources/Dockerfile.j2
    env:
      ANSIBLE_USER: ansible
      DEPLOY_GROUP: deployer
      SUDO_GROUP: wheel
      container: docker
    image: centos:7
    name: centos_7
    privileged: true
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup
provisioner:
  inventory:
    links:
      group_vars: ../resources/inventory/group_vars/
      host_vars: ../resources/inventory/host_vars/
      hosts: ../resources/inventory/hosts.yml
  name: ansible
  options:
    D: true
    vv: true
  playbooks:
    converge: ../resources/playbooks/converge.yml
verifier:
  name: ansible
  playbooks:
    verify: ../resources/tests/verify.yml

CRITICAL Failed to pre-validate.

{'driver': [{'name': ['unallowed value docker']}]}
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/clickhouse$
```

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

```shell
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /home/nrv/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role/molecule/default successfully.
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$
```
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
<details><summary>Instances</summary>

```shell
platforms:
  - name: centos_8
    image: docker.io/pycontribs/centos:8
    pre_build_image: true
  - name: ubuntu_latest
    image: docker.io/pycontribs/ubuntu:latest
    pre_build_image: true
```
</details>

<details><summary>Output</summary>

```shell
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$ molecule converge
INFO     default scenario test matrix: dependency, create, prepare, converge
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/nrv/.cache/ansible-compat/f5bcd7/modules:/home/nrv/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/nrv/.cache/ansible-compat/f5bcd7/collections:/home/nrv/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/nrv/.cache/ansible-compat/f5bcd7/roles:/home/nrv/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > create
INFO     Sanity checks: 'docker'

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j738881950559.3317', 'results_file': '/home/nrv/.ansible_async/j738881950559.3317', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j182965571865.3343', 'results_file': '/home/nrv/.ansible_async/j182965571865.3343', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create directory] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Get distr] *************************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Unarchive files] *******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Create a symlink] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Create init file] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : creating directory for vector data] ************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Creating config for Vector] ********************************
changed: [ubuntu_latest]
changed: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$
```
</details>
4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
<details><summary>Output</summary>

```shell
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/nrv/.cache/ansible-compat/f5bcd7/modules:/home/nrv/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/nrv/.cache/ansible-compat/f5bcd7/collections:/home/nrv/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/nrv/.cache/ansible-compat/f5bcd7/roles:/home/nrv/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
COMMAND: ansible-lint . yamllint .
WARNING: PATH altered to include /usr/bin
WARNING  Computed fully qualified role name of vector install does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

WARNING  Loading custom .yamllint config file, this extends our internal yamllint config.
WARNING  Listing 1 violation(s) that are fatal
role-name: Role name vector install does not match ``^[a-z][a-z0-9_]+$`` pattern
.:1


Finished with 0 failure(s), 1 warning(s) on 8 files.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/nrv/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j176144520346.6681', 'results_file': '/home/nrv/.ansible_async/j176144520346.6681', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j530265204766.6707', 'results_file': '/home/nrv/.ansible_async/j530265204766.6707', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create directory] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Get distr] *************************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Unarchive files] *******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Create a symlink] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Create init file] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : creating directory for vector data] ************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Creating config for Vector] ********************************
changed: [ubuntu_latest]
changed: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create directory] ******************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector-role : Get distr] *************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector-role : Unarchive files] *******************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Create a symlink] ******************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector-role : Create init file] ******************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector-role : creating directory for vector data] ************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector-role : Creating config for Vector] ********************************
ok: [ubuntu_latest]
ok: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Get Vector version] ******************************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [Assert Vector version] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "0.29.1"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Assert Vector config] ****************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n
      Validated"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n
      Validated"
}

PLAY RECAP *********************************************************************
centos_8                   : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
nrv@nrv:~/devops-netology/homeworks/08-ansible-05-testing/playbook/roles/vector-role$
```
</details>
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

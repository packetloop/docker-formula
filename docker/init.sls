docker-python-apt:
  pkg.installed:
    - name: python-apt
    - order: 1

docker-dependencies:
   pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates
    - order: 1

docker_repo:
    pkgrepo.managed:
      - repo: 'deb https://apt.dockerproject.org/repo ubuntu-trusty main'
      - file: '/etc/apt/sources.list.d/docker.list'
      - key_url: salt://docker/docker.pgp
      - require_in:
          - pkg: docker-pkg
      - require:
        - pkg: docker-python-apt
      - order: 1

docker-pkg:
  pkg.installed:
    - name: 'docker-engine'
    - require:
      - pkg: docker-dependencies
    - order: 1

docker-service:
  service.running:
    - name: docker
    - order: 1
    - require:
      - pkg: docker-pkg

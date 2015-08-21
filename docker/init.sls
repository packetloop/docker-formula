docker-python-apt:
  pkg.installed:
    - name: python-apt

docker-dependencies:
   pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates

docker_repo:
    pkgrepo.managed:
      - repo: 'deb https://apt.dockerproject.org/repo ubuntu-trusty main'
      - file: '/etc/apt/sources.list.d/docker.list'
      - key_url: salt://docker/docker.pgp
      - require_in:
          - pkg: docker-pkg
      - require:
        - pkg: docker-python-apt

docker-pkg:
  pkg.latest:
    - name: 'docker-engine'
    - require:
      - pkg: docker-dependencies

docker:
  service.running

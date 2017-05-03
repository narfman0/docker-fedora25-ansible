FROM fedora:25
MAINTAINER Jon Robison
ENV container=docker

# Install Ansible and other requirements.
RUN dnf makecache fast \
 && dnf -y install \
      ansible \
      sudo \
      which \
      python2-dnf \
 && dnf clean all

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/usr/sbin/init"]

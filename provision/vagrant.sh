date > /etc/vagrant_box_build_time

# Set up sudo.  Be careful to set permission BEFORE copying file to sudoers.d
( cat <<'EOP'
%vagrant ALL=NOPASSWD:ALL
EOP
) > /tmp/vagrant
chmod 0440 /tmp/vagrant
mv /tmp/vagrant /etc/sudoers.d/

# Install vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# remove those annoying stdin: is not a tty messages when running vagrant
sed -i "s/mesg n/tty -s \&\& mesg n/g" /root/.profile
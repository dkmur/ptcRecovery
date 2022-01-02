# ptcRecovery

idiots attempt to automate recovery from PTC login IP ban.<br>
<br>
<br>
## Installation
On (MAD) server where
- git clone and copy config file `git clone https://github.com/dkmur/ptcRecovery.git && cd ptcRecovery && cp config.ini.example config.ini`<br>
- enter details in config.ini<br>
- install ncat. Debian `sudo apt install ncat`, Ubuntu `sudo apt install nmap`<br>
- make sure Stats is cloned and up-to-date https://github.com/dkmur/Stats as we use some scripts from it, no need to actually run it<br>
<br>
in case (MAD) server is not located on same WAN IP as devices (setting serverLocal=false):<br>

- clone ptcRecovery on local server `git clone https://github.com/dkmur/ptcRecovery.git && cd ptcRecovery && cp config.ini.example config.ini`<br>
- enter details in config.ini<br>
- open up firewall on remote server for port used<br>
<br>

## Execute using pm2

`pm2 start ptcrecovery.sh --name ptcRecovery -o "/dev/null" -e "/dev/null"`<br>
<br>
On seperate local server, when used (setting serverLocal=false):<br>
`pm2 start localserver.sh --name ptcRecoveryLocal -o "/dev/null" -e "/dev/null"`
<br>

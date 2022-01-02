# ptcRecovery

idiots attempt to automate recovery from PTC login IP ban.<br>
<br>
<br>
## Installation
- git clone and copy config file `https://github.com/dkmur/ptcRecovery.git && cd ptcRecovery && cp config.ini.example config.ini`<br>
- fill out details in config.ini, top part<br>
- install ncat. Debian `sudo apt install ncat`, Ubuntu `sudo apt install nmap`<br>
<br>
in case (MAD) server is not located on same WAN IP as devices (setting serverLocal=false):<br>
- clone ptcRecovery on local server `https://github.com/dkmur/ptcRecovery.git && cd ptcRecovery && cp config.ini.example config.ini`<br>
- fill out details in config.ini, bottom section<br>
- open up firewall for port used<br>
<br>

## Execute using pm2

`pm2 start ptcrecovery.sh --name ptcRecovery -o "/dev/null" -e "/dev/null"`<br>
<br>
On seperate local server, when used (setting serverLocal=false):<br>
`pm2 start localserver.sh --name ptcRecoveryLocal -o "/dev/null" -e "/dev/null"`
<br>

# kali-docker

Official Kali Docker distribution with a set of useful packages for information gathering and vulnerability assessment.

Included packages and tools in Kali Docker image:

**[nmap](https://nmap.org/)**    
Nmap ("Network Mapper") is a free and open source (license) utility for network discovery and security auditing.

**[dnsrecon](https://github.com/darkoperator/dnsrecon)**  
A script that provides the ability to perform DNS records enumeration. 

**[theHarvester](https://github.com/laramies/theHarvester/)**  
theHarvester is a very simple, yet effective tool designed to be used in the early
stages of a penetration test. Use it for open source intelligence gathering and
helping to determine a company's external threat landscape on the internet. 

**[siege](https://www.joedog.org/siege-home/)**  
Siege is an http load testing and benchmarking utility. It was designed to let web developers measure their code under duress, to see how it will stand up to load on the internet.

**[metasploit](https://www.metasploit.com/)**  
Metasploit helps security experts do more than just verify vulnerabilities, manage security assessments, and improve security awareness.

**[gobuster](https://github.com/OJ/gobuster)**

**[speedtest](https://github.com/sivel/speedtest-cli)**  
Command line interface for testing internet bandwidth using speedtest.net

**network utilities**  
ping, nslookup, dig, whois, netcat, telnet, traceroute, netcat, curl, net-tools (package) and more

**database clients**  
mysql, mariadb, postgresql, redis

**custom utilities**  
myip

## Requirements
- Docker 18.02.0+
- make

## Build Kali Docker image
```
make build
```

## How to use
You can run command `kali` in project folder followed by a Kali tool command and related arguments

```
./kali "ping 192.168.1.1"
```

### System-wide usage  
If you prefer to use Kali container as default command launcher, you can create an alias to run Kali tools as system-wide executable:

```
alias kali='$(PWD)/kali'
```

To keep alias between sessions, you can save it in your user’s shell configuration profile file. This can be:

```
Bash – ~/.bashrc
ZSH – ~/.zshrc
Fish – ~/.config/fish/config.fish
```

Quick shell profile inclusion from project `kali-docker` root folder (e.g. bash): 

```
echo "alias kali='`echo $PWD`/kali'" >> ~/.bashrc
```

Now, when you run a new shell in your host, you can use `kali` command everywhere.

Check it! Try to run `kali` command w/o any other command/argument:
```
Kali Docker: Command not found
```
In this case no Kali command specified returns an error message.

## Files storage
All containers executed by `kali` command are temporary containers, it means that every file stored outside folder `/opt` will be lost at container exit.
Main tools that require persistent storage have their working folder in `/opt` 

## Examples
You can run any kind of command installed on Kali container, for a quick summary check the list at the top of this page or try example shown below.  
**Remember:** type Kali commands with arguments in quote: `kali "command arg1 arg2"`

### Bash

You can run and connect to a container and use a standard `bash` cli
```
kali bash
```
**TIP:** A single command w/o arguments doesn't require quote 

### Nmap

Scan a single IP
```
kali "nmap 192.168.1.1"
```

Scan a host
```
kali "nmap hostname.com"
```

Scan a range of IPs (from 192.168.1.1 to 192.168.1.20)
```
kali "nmap 192.168.1.1-20"
```

Scan a subnet
```
kali "nmap 192.168.1.0/24"
```

Scan targets from a text file
```
nmap -iL /opt/nmap/my-list-of-ips-or-hostnames.txt
```
**TIP:** You can create your file with a standard editor like `nano` or `vi`
```
kali "nano /opt/nmap/my-list-of-ips-or-hostnames.txt"
[type a list of hosts or IPs, one per line]
```

### DNSRecon

Brute force domains and hosts using a given dictionary
```
# Default dictionary
kali "dnsrecon -d hostname.com -t brt"

# Custom dictionary
kali "dnsrecon -d hostname.com -t brt -D /opt/dnsrecon/subdomains.wd"
```
**TIP:** Download a file into container persistent folder
```
kali "curl https://github.com/darkoperator/dnsrecon/blob/master/subdomains-top1mil.txt --output /opt/dnsrecon/subdomains.wd"
```

Test all NS servers for a zone transfer
```
kali "dnsrecon -d hostname.com -t axfr"
```

Save results in a json file (more formats are available, check with help: `-h`)
```
kali "dnsrecon -d hostname.com -j /path/to/results.json"
```

### theHarvester

theHarvester requires configuration of api-keys.yaml for following modules:
- bing
- github
- hunter
- intelx
- securityTrails
- shodan
- spyse

You can modify `/opt/theharvester/api-keys.yaml` file:
```
kali "nano /opt/theharvester/api-keys.yaml"
```

Search google, googleCSE, bing, bingapi, pgp, linkedin,google-profiles, jigsaw, twitter, googleplus, all
```
kali "theHarvester -d hostname.com -b all"
```

Searching emails accounts for the domain `hostname.com`, it will work with the first 500 Google results:
```
kali "theHarvester -d hostname.com -l 500 -b google"
```

Use SHODAN database to query discovered hosts
```
kali "theHarvester -d hostname.com -s"	
```

### Gobuster

Gobuster is a tool used to brute-force:
- URIs (directories and files) in web sites.
- DNS subdomains (with wildcard support).
- Virtual Host names on target web servers.


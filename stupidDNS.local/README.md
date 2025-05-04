# stupidDNS.local

The stupidDNS.local service is designed for local use and is not accessible over the network. It is a good idea to use this service only on your system, and the steps to install it are as follows.

## 1. Install docker (ignore this step if docker is installed on your system)
## 2. Clone the Project
```bash
git clone https://github.com/Aydinttb/stupidDNS.git
cd stupidDNS/stupidDNS.local
```
## 3. Run docker compose
```bash
sudo docker compose up -d
```
## 4. Change the system dns to 172.20.20.20

---

## Test
To test whether traffic to your desired domain is passing through this service, you can run the following command: 
```bash
dig +short <your_domain.com> @172.20.20.20
```
If the resolved IP is `172.20.20.22`, it means that your traffic to this domain passes through the stupidDNS service, but if another value is resolved, it means that traffic to the destination domain passes through your system's internet.

---

## Add a domain
If the domain you want does not pass through this service, you can add it to the `dnsmasq/domains.conf` file with the following format and then restart the dnsmasq container
```bash
echo "address=/.example.com/172.20.20.22" >> dnsmasq/domains.conf
sudo docker restart dnsmasq-proxy
```
If the domain is added as `address=/.example.com/172.20.20.22`, it means that the traffic of the domain itself and all subdomains will be passed through the proxy, but if the domain is added as `address=/example.com/172.20.20.22`, only the traffic of the domain `example.com` will be passed through the proxy and not its subdomains.

# stupidDNS
The stupidDNS service is designed for use at the network level and can be accessed and used through the network. This service is very suitable for situations where you have a number of nodes and you want one of the nodes to have the role of local dns and nginx-proxy. The setup steps are as follows:

## 1. Install docker (ignore this step if docker is installed on your system)
## 2. Clone the Project
```bash
git clone https://github.com/Aydinttb/stupidDNS.git
cd stupidDNS/stupidDNS
```
## 3. Put the server IP in the `domains.conf` file 
Find `<YOUR_IP>`
```bash
hostname -I
```
```bash
sed -i s/YOUR_SRV_IP/<YOUR_IP>/g dnsmasq/domains.conf 
```
## 4. Run docker compose
```bash
sudo docker compose up -d
```
If the above steps are completed correctly, your server can serve as a DNS like a shecan1 in the network.
Also, if you need this service to resolve your desired records like a local DNS server, you can add your desired record to the `dnsmasq/domains.conf` file in the following format.

### Guide to adding a node
1. Find `node_name` and `IP` on another node.
```bash
hostname
```
Or
```bash
hostnamectl
```
Static hostname is what you want.

Example:
```bash
address=/node_name/IP
address=/node02/192.168.1.2
```
2. Add a node
If the node you want does not pass through this service, you can add it to the `dnsmasq/domains.conf` file with the following format and then restart the dnsmasq container.
```bash
echo "address=/node_name/IP" >> dnsmasq/domains.conf
sudo docker restart dnsmasq-proxy
```

---

### Guide to adding a domain
If the domain you want does not pass through this service, you can add it to the `dnsmasq/domains.conf` file with the following format and then restart the dnsmasq container.
```bash
echo "address=/.<your_domain>/<YOUR_IP>" >> dnsmasq/domains.conf
sudo docker restart dnsmasq-proxy
```
If the domain is added as `address=/.example.com/IP`, it means that the traffic of the domain itself and all subdomains will be passed through the proxy, but if the domain is added as `address=/example.com/IP`, only the traffic of the domain `example.com` will be passed through the proxy and not its subdomains.

---

## Test
To test whether traffic to your desired domain is passing through this service, you can run the following command:
```bash
dig +short <your_domain.com> @127.0.0.1
```
If the resolved IP is your stupidDNS server IP, it means that your traffic to this domain will pass through the stupidDNS service, but if another value is resolved, it means that traffic to the destination domain will pass through the system's default internet.

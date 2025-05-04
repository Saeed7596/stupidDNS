# stupidDNS
A smart DNS to resolve 403 issues for Iran using Cloudflare Warp.

![2025-04-14-002738_hyprshot](https://github.com/user-attachments/assets/3f14c848-6369-4d11-a2f2-632dbf192b30)


---

This project sets up a service on your local machine using nginx, dnsmasq, warp-plus, and tun2proxy. Its functionality is similar to anti-censorship DNS services (like Shekan DNS), but it does not require a server. All you need is a Docker runtime to run two containers.

The nginx container has access to the unrestricted internet and can connect you to filtered resources. Currently, popular platforms like YouTube, Spotify, Reddit, and others are already configured. Instructions on how to add your own desired domains to this service are provided below.

# stupidDNS.local
This service is designed for local system use. If you only need the DNS proxy locally (and not across your entire network), it is recommended to use this service. This way, no ports on your system's network will be exposed. Usage instructions are available inside the stupidDNS.local directory.

# stupidDNS
This service is designed for network-wide use. If you need the service to be accessible across your entire network, it is recommended to use this setup instead. Usage instructions are available inside the stupidDNS directory.



---
thanks [ Morteza Farkhondepour](https://www.linkedin.com/in/morteza-farkhondepour/) for this idea

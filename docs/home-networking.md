# Networking notes
This will contain my notes on my networking decisions, mostly setup on my MikroTik and Sophos device. These need additional attention in this log because there is no configuration as code and, as of yet, no backups available either.


## Challenges:
- Segregate smart devices from trusted network, this is harder than expected because some of the untrusted devices need to be accessed via a bigger set of protocols such as mDNS repeater. This resulted in a bigger ruleset to allow traffic from and to my trusted devices than I had hoped.
- Segregate a development environment/sandbox environment from trusted net
- My wife started having connectivity issues with her work laptop. Turns out that they use ZScaler that also hands out IP-addresses in the 172.16.0.0/12 CIDR range. I setup a separate network for her to get a 192.168.0.0/16 ranged IP address when on that device.

## Network Design

```mermaid
graph TD
    Internet((Internet))
    OPNSense["OPNSense\nFirewall / Router"]
    Switch["Switch"]

    subgraph VLAN10["VLAN 10 — Infrastructure (172.16.10.0/24)"]
        subgraph Proxmox["Proxmox Cluster (pve)"]
            Pihole["Pi-hole\n LXC Container"]
            PVE1["Windows 11 VM\nPractice environment"]
        end
    end

    subgraph VLAN1["VLAN 1 — Trusted Devices (172.16.3.0/24)"]
        PC1["PC 1"]
        PC2["PC 2"]
        PC3["PC 3"]
    end

    subgraph VLAN2["VLAN 2 — IoT / Smart Devices (172.16.4.0/24)"]
        SmartDevices["Smart Home Devices"]
        TV["TV"]
        Music["Music"]
    end

    subgraph VLAN3["VLAN 3 — Guests (172.16.5.0/24)"]
        GuestDevices["Guest devices"]
    end

    subgraph VLAN4["VLAN 4 — Work / ZScaler (192.168.1.0/24)"]
        WorkLaptop["Wife's work laptop\nZScaler-safe subnet"]
    end

    Internet --> OPNSense
    OPNSense --> Switch
    Switch -->|vlan10| VLAN10
    Switch -->|vlan1| VLAN1
    Switch -->|vlan2| VLAN2
    Switch -->|vlan3| VLAN3
    Switch -->|vlan4| VLAN4

    Pihole -. "DNS" .-> OPNSense
```


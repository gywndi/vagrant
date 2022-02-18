# vagrant for kafka

```bash
vagrant up
```

You can change the VM specification by declaring the environment variable as shown below.
```bash
VM_NAME=el7-kafka       \
VM_MEMORY=4096          \
VM_PASSWORD=root        \
VM_IPADDR=192.168.56.20 \
vagrant up
```

| Environment | Version |
|---|---|
| OS | Oracle Enterprise Linux 7 |
| JAVA | openjdk version "1.8.0_322" |
| KAFKA | kafka_2.13-3.1.0 |

| Parameter | Detail | Default |
|---|---|---|
| VM_NAME | VM name | el7-kafka |
| VM_MEMORY | VM memory size (MB) | 4096 |
| VM_PASSWORD | root password | root |
| VM_IPADDR| VM private IP address | 192.168.56.20 |

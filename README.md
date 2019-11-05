# zabbix-website-content-monitor

## Configuration
1. Run `make edit` to add host details  
2. Run `make create` to build template  
3. Import `build/web-content.xml` into Zabbix  

## Creating a screen
| Setting | Value |  
| --- | --- |  
| Resource |Trigger Overview |  
| Group | The group you entered at build |  
| Application | HTTP Content Check |  
| Hosts Location | Top |  

  
Tested with Zabbix 3.2

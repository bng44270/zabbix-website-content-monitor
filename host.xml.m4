<?xml version="1.0" encoding="UTF-8"?>
<zabbix_export>
    <version>3.2</version>
    <groups>
        <group>
            <name>HOSTGROUP</name>
        </group>
    </groups>
    <hosts>
        <host>
            <host>ZBXHOST</host>
            <name>ZBXHOST</name>
            <description/>
            <proxy/>
            <status>0</status>
            <ipmi_authtype>-1</ipmi_authtype>
            <ipmi_privilege>2</ipmi_privilege>
            <ipmi_username/>
            <ipmi_password/>
            <tls_connect>1</tls_connect>
            <tls_accept>1</tls_accept>
            <tls_issuer/>
            <tls_subject/>
            <tls_psk_identity/>
            <tls_psk/>
            <templates/>
            <groups>
                <group>
                    <name>HOSTGROUP</name>
                </group>
            </groups>
            <interfaces>
                <interface>
                    <default>1</default>
                    <type>1</type>
                    <useip>1</useip>
                    <ip>127.0.0.1</ip>
                    <dns/>
                    <port>10050</port>
                    <bulk>1</bulk>
                    <interface_ref>if1</interface_ref>
                </interface>
            </interfaces>
            <applications>
                <application>
                    <name>HTTP Content Check</name>
                </application>
            </applications>
            <items/>
            <discovery_rules/>
            <httptests>
ALLHTTPTESTS
            </httptests>
            <macros/>
            <inventory/>
        </host>
    </hosts>
    <triggers>
ALLTRIGGERS
    </triggers>
    <graphs>
ALLGRAPHS
    </graphs>
</zabbix_export>

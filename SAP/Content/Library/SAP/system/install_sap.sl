########################################################################################################################
#!!
#! @description: Installs SAP on CentOS. There must be the installation files already placed on the linux VM. Certain pre-requisites must be also done, like
#!               #install necessary dependencies
#!               sudo yum install -a tcsh uuidd libaio sshpass
#!               #disable firewall
#!               sudo systemctl disable firewalld
#!               sudo systemctl stop firewalld
#!               #disable selinux
#!               #set hostname to a simple 13 characters max string (no special characters)
#!               #make install.sh file executable
#!
#! @input host: VM host where to install SAP
#! @input username: User name of the VM where to install SAP
#! @input password: User password of the VM where to install SAP
#! @input install_path: Path to the installation script
#! @input log_path: Path to the installation log (additional logs are located in /tmp/
#! @input timeout: Time in milliseconds to wait for the installation to complete
#! @input sap_password: Password of the linux users npladm and sybnpl (created during installation)
#!!#
########################################################################################################################
namespace: SAP.system
flow:
  name: install_sap
  inputs:
    - host: sapdemo.mf-te.com
    - username: centos
    - password:
        default: 'go.MF.admin123!'
        sensitive: true
    - install_path: /install/sapinst/install.sh
    - log_path: /tmp/install-sap.log
    - timeout: '7200000'
    - sap_password:
        default: Cloud123
        sensitive: true
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: |-
                ${'''sudo %s -s &> %s << EOF

                yes
                %s
                %s
                EOF''' % (install_path, log_path, sap_password, sap_password)}
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - timeout: '${timeout}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ssh_command:
        x: 78
        'y': 87
        navigate:
          6c97c23e-b568-7a57-a0e7-28259974b1c4:
            targetId: 52f28d62-ea6a-6e4c-1492-fe47cce9dd7d
            port: SUCCESS
    results:
      SUCCESS:
        52f28d62-ea6a-6e4c-1492-fe47cce9dd7d:
          x: 264
          'y': 95

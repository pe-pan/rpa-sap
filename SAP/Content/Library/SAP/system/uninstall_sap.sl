########################################################################################################################
#!!
#! @description: Uninstalls SAP from CentOS.
#!
#! @input host: VM host where to uninstall SAP
#! @input username: User name of the VM where to uninstall SAP
#! @input password: User password of the VM where to uninstall SAP
#! @input log_path: Path to the uninstallation log
#! @input timeout: Time in milliseconds to wait for the uninstallation to complete
#! @input sap_password: Password of the linux users npladm and sybnpl (created during installation)
#! @input reboot: Set to true if the VM should get rebooted upon SAP uninstallation
#!!#
########################################################################################################################
namespace: SAP.system
flow:
  name: uninstall_sap
  inputs:
    - host: sapdemo.mf-te.com
    - username: centos
    - password:
        default: 'go.MF.admin123!'
        sensitive: true
    - log_path: /tmp/uninstall-sap.log
    - timeout: '300000'
    - sap_password:
        default: Cloud123
        sensitive: true
    - reboot: 'true'
  workflow:
    - uninstall:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: |-
                ${'''
                echo "01. Stopping SAP..." > %s
                su - npladm -c stopsap all &>> %s << EOF
                %s
                EOF
                echo "02. Stopping SAP init service..." >> %s
                sudo /etc/init.d/sapinit stop &>> %s
                echo "03. Removing folders..." >> %s
                sudo rm -rf /sapmnt/ /sybase/ /usr/sap/ &>> %s
                echo "04. Removing users..." >> %s
                sudo userdel npladm &>> %s
                sudo userdel sapadm &>> %s
                sudo userdel sybnpl &>> %s
                echo "05. Removing service..." >> %s
                sudo rm -rf /etc/init.d/sapinit &>> %s
                echo "06. Removing ports..." >> %s
                sudo sed -i.bak '/sapmsNPL/Q' /etc/services &>> %s''' % (log_path, log_path, sap_password, log_path, log_path, log_path, log_path, log_path, log_path, log_path, log_path, log_path, log_path, log_path, log_path)}
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - timeout: '${timeout}'
        navigate:
          - SUCCESS: should_reboot
          - FAILURE: on_failure
    - reboot:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: |-
                ${'''
                echo "07. Rebooting..." >> %s
                sudo reboot''' % (log_path)}
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - timeout: '${timeout}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: SUCCESS
    - should_reboot:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${reboot}'
            - second_string: 'true'
            - ignore_case: 'true'
        navigate:
          - SUCCESS: reboot
          - FAILURE: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      uninstall:
        x: 78
        'y': 87
      reboot:
        x: 74
        'y': 291
        navigate:
          af2dda92-9e62-cdd4-0be6-99b99b3abae1:
            targetId: 52f28d62-ea6a-6e4c-1492-fe47cce9dd7d
            port: FAILURE
          9c9bc55b-a2c2-1411-85e4-439b6e06cd4e:
            targetId: 52f28d62-ea6a-6e4c-1492-fe47cce9dd7d
            port: SUCCESS
      should_reboot:
        x: 310
        'y': 69
        navigate:
          02e3aad7-a38f-7199-aca7-64cb09118c67:
            targetId: 52f28d62-ea6a-6e4c-1492-fe47cce9dd7d
            port: FAILURE
    results:
      SUCCESS:
        52f28d62-ea6a-6e4c-1492-fe47cce9dd7d:
          x: 285
          'y': 295

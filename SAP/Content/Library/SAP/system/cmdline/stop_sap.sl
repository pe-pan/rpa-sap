########################################################################################################################
#!!
#! @description: Stops an SAP instance if started.
#!!#
########################################################################################################################
namespace: SAP.system.cmdline
flow:
  name: stop_sap
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: "${get_sp('sapdemo.host')}"
            - command: stopsap all
            - username: "${get_sp('sapdemo.sap_os_username')}"
            - password:
                value: "${get_sp('sapdemo.sap_os_password')}"
                sensitive: true
            - timeout: '300000'
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
        x: 116
        'y': 104
        navigate:
          f273f9c7-060f-bb41-3981-1fd66427561e:
            targetId: abfaae88-fe8a-2395-6c23-cdc616ab8215
            port: SUCCESS
    results:
      SUCCESS:
        abfaae88-fe8a-2395-6c23-cdc616ab8215:
          x: 329
          'y': 107

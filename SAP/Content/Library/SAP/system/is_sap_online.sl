########################################################################################################################
#!!
#! @description: Tries to connect to SAP server and fails if SAP server not reachable.
#!
#! @input sap_connection: SAP GUI connection used to connect to SAP server
#! @input attempts: How many times to try to connect to the SAP server
#! @input timeout: Waiting time (in seconds) between two attempts
#!
#! @output online: True if SAP server reachable; false otherwise
#!
#! @result SUCCESS: When SAP server is online
#! @result FAILURE: When SAP server can't be reached
#!!#
########################################################################################################################
namespace: SAP.system
flow:
  name: is_sap_online
  inputs:
    - sap_connection: INTERNAL
    - attempts: '10'
    - timeout: '15'
  workflow:
    - is_sap_online_act:
        do:
          SAP.system.is_sap_online_act:
            - sap_connection: '${sap_connection}'
            - attempts: '${attempts}'
            - timeout: '${timeout}'
        publish:
          - online: "${'false' if online == '0' else 'true'}"
        navigate:
          - SUCCESS: is_online
          - WARNING: is_online
          - FAILURE: on_failure
    - is_online:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${online}'
            - second_string: 'true'
            - ignore_case: 'true'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - online: '${online}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      is_sap_online_act:
        x: 67
        'y': 99
      is_online:
        x: 297
        'y': 81
        navigate:
          99d69967-6e62-27c2-b3a0-9b07de76957d:
            targetId: c1e894e9-1397-0499-8c1f-b7a04d128242
            port: SUCCESS
    results:
      SUCCESS:
        c1e894e9-1397-0499-8c1f-b7a04d128242:
          x: 453
          'y': 97

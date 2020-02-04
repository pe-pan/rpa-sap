########################################################################################################################
#!!
#! @description: Tries to connect to SAP server and returns true / false depending on the server is reachable.
#!!#
########################################################################################################################
namespace: SAP.system
operation:
  name: is_sap_online_act
  inputs:
    - sap_connection
    - attempts
    - timeout
  sequential_action:
    gav: 'com.microfocus.seq:SAP.system.is_sap_online_act:1.0.4'
    external: true
  outputs:
    - online:
        robot: true
        value: '${online}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

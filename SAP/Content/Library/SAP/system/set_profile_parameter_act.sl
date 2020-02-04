namespace: SAP.system
operation:
  name: set_profile_parameter_act
  inputs:
    - sap_connection
    - sap_admin_name
    - sap_admin_password
    - parameter_name
    - parameter_value
  sequential_action:
    gav: 'com.microfocus.seq:SAP.system.set_profile_parameter_act:1.0.4'
    external: true
  outputs:
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

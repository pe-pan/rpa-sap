namespace: SAP.user.address
operation:
  name: set_company_address_act
  inputs:
    - sap_connection
    - sap_admin_name
    - sap_admin_password
    - company_name
  sequential_action:
    gav: 'com.microfocus.seq:SAP.user.address.set_company_address_act:1.0.0'
    external: true
  outputs:
    - company_status:
        robot: true
        value: '${company_status}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

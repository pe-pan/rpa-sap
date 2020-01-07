########################################################################################################################
#!!
#! @description: Sets company default address to be used when creating new users.
#!               ITELO and ITELO1 values can be used in a freshly installed SAP server (demo data).
#!               SAP scripting must be enabled.
#!!#
########################################################################################################################
namespace: SAP.user.address
flow:
  name: set_company_address
  inputs:
    - sap_connection: INTERNAL
    - sap_admin_name: 'sap*'
    - sap_admin_password:
        default: Appl1ance
        sensitive: true
    - company_name: ITELO
  workflow:
    - set_company_address_act:
        do:
          SAP.user.address.set_company_address_act:
            - sap_connection: '${sap_connection}'
            - sap_admin_name: '${sap_admin_name}'
            - sap_admin_password: '${sap_admin_password}'
            - company_name: '${company_name}'
        publish:
          - company_status
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - company_status: '${company_status}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      set_company_address_act:
        x: 88
        'y': 105
        navigate:
          66627c02-e424-9b4b-d57c-30470e9eab54:
            targetId: 8454e3e3-6546-105b-0395-50a72464fe3e
            port: SUCCESS
          67692e32-9b92-0f79-9ea4-26225bd17736:
            targetId: 8454e3e3-6546-105b-0395-50a72464fe3e
            port: WARNING
    results:
      SUCCESS:
        8454e3e3-6546-105b-0395-50a72464fe3e:
          x: 295
          'y': 106

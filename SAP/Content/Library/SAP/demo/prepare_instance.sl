########################################################################################################################
#!!
#! @description: Installs and configure SAP server for the first use. It
#!                 - installs SAP server
#!                 - enables SAP user scripting (sets sapgui/user_scripting profile parameter to true)
#!                 - sets default company address
#!                 - creates an admin user
#!               Most of properties are taken from sapdemo system properties file.
#!               
#!
#! @input sap_connection: SAP GUI connection used to connect to SAP server
#! @input company_name: Company address used for newly created users
#! @input first_user_name: Created admin user
#! @input first_user_password: Password of the created admin user
#!!#
########################################################################################################################
namespace: SAP.demo
flow:
  name: prepare_instance
  inputs:
    - sap_connection:
        default: INTERNAL
        required: false
    - company_name:
        default: ITELO
        required: false
    - first_user_name:
        default: admin
        required: false
    - first_user_password:
        default: Cloud@123
        required: false
        sensitive: true
  workflow:
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: 'true'
            - second_string: 'false'
        navigate:
          - SUCCESS: install_sap
          - FAILURE: set_profile_parameter
    - install_sap:
        do:
          SAP.system.install_sap:
            - host: "${get_sp('sapdemo.host')}"
            - username: "${get_sp('sapdemo.username')}"
            - password:
                value: "${get_sp('sapdemo.password')}"
                sensitive: true
            - install_path: "${get_sp('sapdemo.install_path')}"
            - sap_password:
                value: "${get_sp('sapdemo.sap_os_password')}"
                sensitive: true
        navigate:
          - FAILURE: on_failure
          - SUCCESS: set_profile_parameter
    - set_profile_parameter:
        do:
          SAP.system.set_profile_parameter:
            - sap_connection: "${get('sap_connection', get_sp('sapdemo.sap_connection'))}"
            - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
            - sap_admin_password:
                value: "${get_sp('sapdemo.sap_admin_password')}"
                sensitive: true
            - parameter_name: sapgui/user_scripting
            - parameter_value: 'TRUE'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: set_company_address
    - set_company_address:
        do:
          SAP.user.address.set_company_address:
            - sap_connection: "${get('sap_connection', get_sp('sapdemo.sap_connection'))}"
            - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
            - sap_admin_password:
                value: "${get_sp('sapdemo.sap_admin_password')}"
                sensitive: true
            - company_name: "${get('company_name', get_sp('sapdemo.company_name'))}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: configure_user
    - configure_user:
        do:
          SAP.user.configure_user:
            - sap_connection: "${get('sap_connection', get_sp('sapdemo.sap_connection'))}"
            - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
            - sap_admin_password:
                value: "${get_sp('sapdemo.sap_admin_password')}"
                sensitive: true
            - user_name: "${get('first_user_name', get_sp('sapdemo.first_user_name'))}"
            - last_name: '${user_name}'
            - temp_password:
                value: cloud1
                sensitive: true
            - password:
                value: "${get('first_user_password', get_sp('sapdemo.first_user_password'))}"
                sensitive: true
            - profile: SAP_ALL
            - reuse_old_data: 'true'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_sap:
        x: 63
        'y': 108
      set_profile_parameter:
        x: 209
        'y': 106
      set_company_address:
        x: 352
        'y': 107
      configure_user:
        x: 507
        'y': 109
        navigate:
          7cbcc895-2725-0a03-d45a-f7ed848ff4dd:
            targetId: d93bd551-f434-5f86-b718-05e0d8f59ca7
            port: SUCCESS
      string_equals:
        x: 167
        'y': 287
    results:
      SUCCESS:
        d93bd551-f434-5f86-b718-05e0d8f59ca7:
          x: 653
          'y': 104

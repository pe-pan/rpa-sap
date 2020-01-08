########################################################################################################################
#!!
#! @description: Installs and configure SAP server for the first use. It
#!               - installs SAP server
#!               - enables SAP user scripting (sets sapgui/user_scripting profile parameter to true)
#!               - sets default company address
#!               - creates an admin user
#!               Most of properties are taken from sapdemo system properties file.
#!
#! @input sap_connection: SAP GUI connection used to connect to SAP server
#! @input company_name: Company address used for newly created users
#! @input first_user_name: Created admin user
#! @input first_user_password: Password of the created admin user
#! @input skip_installation: If true, the SAP is not installed but configured only
#!
#! @output online: True/false depending
#! @output company_status: Status of assigning the standard default company address
#! @output user_status: Status of creating the first user
#! @output user_password: Password of the created first user (might be different from the input value)
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
    - skip_installation:
        default: 'false'
        required: false
  workflow:
    - skip_installation:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${skip_installation}'
            - second_string: 'true'
            - ignore_case: 'true'
        navigate:
          - SUCCESS: is_sap_online
          - FAILURE: install_sap
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
          - SUCCESS: is_sap_online
    - enable_scripting:
        loop:
          for: attempt in range(5)
          do:
            SAP.system.set_profile_parameter:
              - sap_connection: "${get('sap_connection', get_sp('sapdemo.sap_connection'))}"
              - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
              - sap_admin_password:
                  value: "${get_sp('sapdemo.sap_admin_password')}"
                  sensitive: true
              - parameter_name: sapgui/user_scripting
              - parameter_value: 'TRUE'
          break:
            - SUCCESS
        navigate:
          - FAILURE: on_failure
          - SUCCESS: set_company_address
    - set_company_address:
        loop:
          for: attempts in range(5)
          do:
            SAP.user.address.set_company_address:
              - sap_connection: "${get('sap_connection', get_sp('sapdemo.sap_connection'))}"
              - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
              - sap_admin_password:
                  value: "${get_sp('sapdemo.sap_admin_password')}"
                  sensitive: true
              - company_name: "${get('company_name', get_sp('sapdemo.company_name'))}"
          break:
            - SUCCESS
          publish:
            - company_status
        navigate:
          - FAILURE: on_failure
          - SUCCESS: create_admin
    - create_admin:
        loop:
          for: attempts in range(5)
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
          break:
            - SUCCESS
          publish:
            - user_status
            - user_password
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - is_sap_online:
        do:
          SAP.system.is_sap_online:
            - sap_connection: INTERNAL
            - attempts: '10'
            - timeout: '15'
        publish:
          - online
        navigate:
          - SUCCESS: enable_scripting
          - FAILURE: on_failure
  outputs:
    - online: '${online}'
    - company_status: '${company_status}'
    - user_status: '${user_status}'
    - user_password:
        value: '${user_password}'
        sensitive: true
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      skip_installation:
        x: 74
        'y': 87
      install_sap:
        x: 43
        'y': 306
      enable_scripting:
        x: 214
        'y': 300
      set_company_address:
        x: 383
        'y': 299
      create_admin:
        x: 373
        'y': 110
        navigate:
          7cbcc895-2725-0a03-d45a-f7ed848ff4dd:
            targetId: d93bd551-f434-5f86-b718-05e0d8f59ca7
            port: SUCCESS
      is_sap_online:
        x: 220
        'y': 102
    results:
      SUCCESS:
        d93bd551-f434-5f86-b718-05e0d8f59ca7:
          x: 567
          'y': 117

########################################################################################################################
#!!
#! @input row: Values delimited by , from a single excel sheet row
#! @input map: Map where keys are the header names and values are the indexes of their columns
#! @input set_admin: True if the created user should be also set as admin
#!!#
########################################################################################################################
namespace: SAP.user.bulk.subflows
flow:
  name: create_user_from_row
  inputs:
    - row
    - map
    - username_header
    - password_header
    - name_header
    - email_header
    - set_admin
  workflow:
    - row_to_values:
        do:
          SAP.user.bulk.subflows.row_to_values:
            - row: '${row}'
            - map: '${map}'
            - name_header: '${name_header}'
            - username_header: '${username_header}'
            - password_header: '${password_header}'
            - email_header: '${email_header}'
        publish:
          - username
          - password
          - first_name
          - last_name
          - email
        navigate:
          - SUCCESS: configure_user
    - configure_user:
        do:
          SAP.user.configure_user:
            - sap_connection: "${get_sp('sapdemo.sap_connection')}"
            - sap_admin_name: "${get_sp('sapdemo.sap_admin_name')}"
            - sap_admin_password:
                value: "${get_sp('sapdemo.sap_admin_password')}"
                sensitive: true
            - user_name: '${username}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: '${email}'
            - password:
                value: '${password}'
                sensitive: true
            - profile: "${'SAP_ALL' if set_admin.lower() == 'true' else ''}"
        publish:
          - user_status
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      row_to_values:
        x: 123
        'y': 124
      configure_user:
        x: 278
        'y': 114
        navigate:
          d1b88ac1-b39d-2c2c-c885-0cd77cb2f5ff:
            targetId: 85589f6d-0a8d-f072-f30b-c887cef9fb4e
            port: SUCCESS
    results:
      SUCCESS:
        85589f6d-0a8d-f072-f30b-c887cef9fb4e:
          x: 432
          'y': 127

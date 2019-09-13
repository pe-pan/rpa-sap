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
          - SUCCESS: create_user
    - create_user:
        do:
          SAP.user.create_user:
            - username: '${username}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: '${email}'
            - password: '${password}'
            - set_admin: '${set_admin}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      row_to_values:
        x: 123
        'y': 124
      create_user:
        x: 281
        'y': 128
        navigate:
          a337f679-0367-2d1f-2722-cb7e685c9486:
            targetId: 85589f6d-0a8d-f072-f30b-c887cef9fb4e
            port: SUCCESS
    results:
      SUCCESS:
        85589f6d-0a8d-f072-f30b-c887cef9fb4e:
          x: 432
          'y': 127

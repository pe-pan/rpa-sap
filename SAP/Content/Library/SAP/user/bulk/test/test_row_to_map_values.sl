namespace: SAP.user.bulk.test
flow:
  name: test_row_to_map_values
  inputs:
    - headers: 'Name, Username, Email, Password'
    - values: 'Petr Panuska, pe.pan, petr.panuska@microfocus.com, cloud1'
    - name_header: Name
    - username_header: Username
    - email_header: Email
    - password_header: Password
  workflow:
    - row_to_map:
        do:
          SAP.user.bulk.subflows.row_to_map:
            - row: '${headers}'
        publish:
          - map
        navigate:
          - SUCCESS: row_to_values
    - row_to_values:
        do:
          SAP.user.bulk.subflows.row_to_values:
            - row: '${values}'
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
          - name
        navigate:
          - SUCCESS: verify_name
    - verify_name:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${name}'
            - second_string: Petr Panuska
        publish: []
        navigate:
          - SUCCESS: verify_username
          - FAILURE: on_failure
    - verify_username:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${username}'
            - second_string: pe.pan
        navigate:
          - SUCCESS: verify_password
          - FAILURE: on_failure
    - verify_password:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${password}'
            - second_string: cloud1
        navigate:
          - SUCCESS: verify_email
          - FAILURE: on_failure
    - verify_email:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${email}'
            - second_string: petr.panuska@microfocus.com
        navigate:
          - SUCCESS: verify_first_name
          - FAILURE: on_failure
    - verify_first_name:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${first_name}'
            - second_string: Petr
        navigate:
          - SUCCESS: verify_last_name
          - FAILURE: on_failure
    - verify_last_name:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${last_name}'
            - second_string: Panuska
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      row_to_map:
        x: 88
        'y': 131
      row_to_values:
        x: 265
        'y': 132
      verify_name:
        x: 131
        'y': 294
      verify_username:
        x: 312
        'y': 291
      verify_password:
        x: 467
        'y': 110
      verify_email:
        x: 472
        'y': 299
      verify_first_name:
        x: 624
        'y': 115
      verify_last_name:
        x: 635
        'y': 311
        navigate:
          4918dfb2-cd6b-d856-ee76-3893c4c735e8:
            targetId: 596745b6-d7fd-01a1-b5c1-4b1a5044da1e
            port: SUCCESS
    results:
      SUCCESS:
        596745b6-d7fd-01a1-b5c1-4b1a5044da1e:
          x: 741
          'y': 139

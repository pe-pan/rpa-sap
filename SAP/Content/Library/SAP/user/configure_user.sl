namespace: SAP.user
flow:
  name: configure_user
  inputs:
  - sap_connection
  - sap_admin_name
  - sap_admin_password
  - user_name
  - first_name
  - last_name
  - email
  - temp_password:
        required: false
  - password:
        required: false
  - title:
        required: false
  - academic_title:
        required: false
  - language:
        required: false
  - function:
        required: false
  - department:
        required: false
  - room:
        required: false
  - floor:
        required: false
  - building:
        required: false
  - phone:
        required: false
  - phone_ext:
        required: false
  - mobile:
        required: false
  - fax:
        required: false
  - fax_ext:
        required: false
  - method:
        required: false
  - start_menu:
        required: false
  - logon_language:
        required: false
  - decimal_notation:
        required: false
  - date_format:
        required: false
  - time_format:
        required: false
  - time_zone:
        required: false
  - profile:
        required: false
  outputs:
  - user_status
  - user_password
  - return_result
  - error_message
  workflow:
    - configure_user_act:
        do:
          SAP.user.configure_user_act: []
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      configure_user_act:
        x: 130
        'y': 125
        navigate:
          06c84b8e-6e7c-9921-179e-578e70957331:
            targetId: 0f49006a-b098-5389-5225-1f69d37acdf9
            port: SUCCESS
          31b3620a-abec-5d39-144b-baa49f26decb:
            targetId: 0f49006a-b098-5389-5225-1f69d37acdf9
            port: WARNING
    results:
      SUCCESS:
        0f49006a-b098-5389-5225-1f69d37acdf9:
          x: 359
          'y': 127

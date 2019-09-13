namespace: SAP.Admin
flow:
  name: Create_Admin_User_flow
  inputs:
    - username
    - first_name
    - last_name
    - email
    - password
  workflow:
    - Create_User:
        do:
          SAP.Create_User:
            - username: '${username}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: '${email}'
            - password: '${password}'
        publish:
          - user_status
        navigate:
          - SUCCESS: Set_User_Admin
          - WARNING: Set_User_Admin
          - FAILURE: on_failure
    - Set_User_Admin:
        do:
          SAP.Admin.Set_User_Admin:
            - user_id: '${username}'
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - order_status: '${order_status}'
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Create_User:
        x: 142
        'y': 156
      Set_User_Admin:
        x: 321
        'y': 149
        navigate:
          6de9960d-b078-c72f-22c3-308b4bd95641:
            targetId: 1a927114-dbfe-a4d6-9c42-e518a8ee5eb6
            port: SUCCESS
          4a5af484-6796-8a4c-aef2-37009c835716:
            targetId: 1a927114-dbfe-a4d6-9c42-e518a8ee5eb6
            port: WARNING
    results:
      SUCCESS:
        1a927114-dbfe-a4d6-9c42-e518a8ee5eb6:
          x: 495
          'y': 141

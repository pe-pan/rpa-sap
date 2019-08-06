namespace: SAP
flow:
  name: Create_User_flow
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
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - user_status
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Create_User:
        x: 100
        'y': 150
        navigate:
          56500b42-fb08-2b23-bc46-b41aca77cf80:
            targetId: 66c5a32a-6420-321b-6f52-f48868e1b489
            port: SUCCESS
          47b378f3-91dc-d85a-a27d-f43c6391a876:
            targetId: 66c5a32a-6420-321b-6f52-f48868e1b489
            port: WARNING
    results:
      SUCCESS:
        66c5a32a-6420-321b-6f52-f48868e1b489:
          x: 400
          'y': 150

########################################################################################################################
#!!
#! @description: Creates a SAP user. Optionally, it attaches the SAP_ALL profile to the user thus making the user an admin.
#!!#
########################################################################################################################
namespace: SAP.user
flow:
  name: create_user
  inputs:
    - username
    - first_name
    - last_name
    - email
    - password
    - set_admin: 'true'
  workflow:
    - create_user_act:
        do:
          SAP.user.create_user_act:
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
          - SUCCESS: is_admin
          - WARNING: is_admin
          - FAILURE: on_failure
    - is_admin:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${set_admin}'
            - second_string: 'true'
            - ignore_case: 'true'
        navigate:
          - SUCCESS: set_admin
          - FAILURE: on_failure
    - set_admin:
        do:
          SAP.user.admin.set_admin:
            - username: '${username}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
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
      create_user_act:
        x: 100
        'y': 150
      is_admin:
        x: 319
        'y': 124
      set_admin:
        x: 430
        'y': 138
        navigate:
          450438fc-36ad-5ef7-5a61-caa8e1ae13a3:
            targetId: 66c5a32a-6420-321b-6f52-f48868e1b489
            port: SUCCESS
    results:
      SUCCESS:
        66c5a32a-6420-321b-6f52-f48868e1b489:
          x: 584
          'y': 137

########################################################################################################################
#!!
#! @input username: Which user to reset password for
#! @input password: New password
#!!#
########################################################################################################################
namespace: SAP.user.reset
flow:
  name: reset_password
  inputs:
    - username
    - password
  workflow:
    - reset_password_act:
        do:
          SAP.user.reset.reset_password_act:
            - user: '${username}'
            - password: '${password}'
        publish:
          - status
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - status
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      reset_password_act:
        x: 100
        'y': 150
        navigate:
          69289008-1d1c-4bbb-17cc-cbaacea39dfd:
            targetId: 1c1f0192-8450-11d1-1168-b31a4c17c50f
            port: SUCCESS
          42f9a174-3f63-b03c-7283-3b6dd3b4d7b3:
            targetId: 1c1f0192-8450-11d1-1168-b31a4c17c50f
            port: WARNING
    results:
      SUCCESS:
        1c1f0192-8450-11d1-1168-b31a4c17c50f:
          x: 400
          'y': 150

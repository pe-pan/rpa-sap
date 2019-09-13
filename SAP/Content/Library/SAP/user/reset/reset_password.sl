########################################################################################################################
#!!
#! @input user: Which user to reset password for
#! @input password: New password
#!!#
########################################################################################################################
namespace: SAP.Reset_Password
flow:
  name: Reset_User_Password_flow
  inputs:
    - user
    - password
  workflow:
    - Reset_User_Password:
        do:
          SAP.Reset_Password.Reset_User_Password:
            - user: '${user}'
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
      Reset_User_Password:
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

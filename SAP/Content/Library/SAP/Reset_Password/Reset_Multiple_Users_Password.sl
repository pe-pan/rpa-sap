namespace: SAP.Reset_Password
flow:
  name: Reset_Multiple_Users_Password
  inputs:
    - username_prefix
    - start_index
    - last_index
    - password
  workflow:
    - Reset_User_Password_flow:
        parallel_loop:
          for: 'index in range(int(start_index), int(last_index)+1)'
          do:
            SAP.Reset_Password.Reset_User_Password_flow:
              - user: '${username_prefix+str(index)}'
              - password: '${password}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Reset_User_Password_flow:
        x: 113
        'y': 99
        navigate:
          73a45a4c-a8fb-bbd7-eef1-f350e96cfa16:
            targetId: 79081a54-b31e-7393-dac4-74cf52e2676a
            port: SUCCESS
    results:
      SUCCESS:
        79081a54-b31e-7393-dac4-74cf52e2676a:
          x: 291
          'y': 110

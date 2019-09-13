########################################################################################################################
#!!
#! @description: Resets passwords of multiple SAP users.
#!               Couple of examples on formating
#!                  {:03d}          user001, user002, user003, ... user030
#!                  user{}          user1, user2, user3, ... user30
#!               FMI on format, see https://pyformat.info/
#!               
#!
#! @input username_format: user{:03d} will generate users like user001, user002, user003 ... user030
#!!#
########################################################################################################################
namespace: SAP.user.reset.bulk
flow:
  name: reset_passwords
  inputs:
    - start_index: '1'
    - last_index: '30'
    - username_format: 'user{:03d}'
    - password_format: cloud1
  workflow:
    - Reset_User_Password_flow:
        parallel_loop:
          for: 'index in range(int(start_index), int(last_index)+1)'
          do:
            SAP.user.reset.reset_password:
              - user: '${username_format.format(index)}'
              - password: '${password_format.format(index)}'
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

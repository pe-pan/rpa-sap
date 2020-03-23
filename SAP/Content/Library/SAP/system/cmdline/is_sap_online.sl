########################################################################################################################
#!!
#! @description: Verifies the SAP instance is reachable; waits the specified amount of time if not and fails; otherwise succeeds.
#!
#! @input seconds: How much time to sleep when the instance not online yet
#!!#
########################################################################################################################
namespace: SAP.system.cmdline
flow:
  name: is_sap_online
  inputs:
    - seconds: '10'
  workflow:
    - run_command:
        do:
          io.cloudslang.base.cmd.run_command:
            - command: "${'\"%s\" -c -X9 -H %s -S %s' % (get_sp('sapdemo.niping'), get_sp('sapdemo.host'), get_sp('sapdemo.port'))}"
        publish:
          - return_result
          - return_code
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: sleep
    - sleep:
        do:
          io.cloudslang.base.utils.sleep:
            - seconds: '${seconds}'
        navigate:
          - SUCCESS: FAILURE
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      run_command:
        x: 108
        'y': 101
        navigate:
          ee967147-36fc-82d6-181c-5d1001d0f19c:
            targetId: 9d3589e0-4584-e9ea-09c8-213dc9e72aab
            port: SUCCESS
      sleep:
        x: 104
        'y': 295
        navigate:
          60a5da7f-9e37-4a4b-f1f0-abca3fe9e0b4:
            targetId: ff80ac72-3e83-d38f-f32f-f8a1305157a7
            port: SUCCESS
          1a9f6d31-04dc-fef0-56f4-6240fc55b987:
            targetId: ff80ac72-3e83-d38f-f32f-f8a1305157a7
            port: FAILURE
    results:
      SUCCESS:
        9d3589e0-4584-e9ea-09c8-213dc9e72aab:
          x: 318
          'y': 98
      FAILURE:
        ff80ac72-3e83-d38f-f32f-f8a1305157a7:
          x: 303
          'y': 290

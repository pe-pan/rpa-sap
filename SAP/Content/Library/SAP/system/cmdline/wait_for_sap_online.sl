########################################################################################################################
#!!
#! @description: Waits for an SAP instance to become online. It waits 1, 2, 4, 8, 16, 32, ... etc seconds between each two unsuccessful attempts.
#!
#! @input attempts: How many times to try if SAP is online until it fails.
#!!#
########################################################################################################################
namespace: SAP.system.cmdline
flow:
  name: wait_for_sap_online
  inputs:
    - attempts: '10'
  workflow:
    - is_sap_online:
        loop:
          for: 'seconds in range(0, int(attempts))'
          do:
            SAP.system.cmdline.is_sap_online:
              - seconds: '${str(2**seconds)}'
          break:
            - SUCCESS
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      is_sap_online:
        x: 169
        'y': 81
        navigate:
          13de3821-244e-b7fc-ab32-c8350a336768:
            targetId: c654fbcc-70e4-da96-5caf-2630e9698147
            port: SUCCESS
    results:
      SUCCESS:
        c654fbcc-70e4-da96-5caf-2630e9698147:
          x: 336
          'y': 85

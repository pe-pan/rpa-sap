########################################################################################################################
#!!
#! @description: Waits for an SAP instance to become online. It waits 1, 2, 4, 8, 16, 32, ... etc seconds between each two unsuccessful attempts.
#!               If the niping_tool is not given (see SAP.niping property), it tries to use SAP Logon GUI to verify the condition.
#!
#! @input attempts: How many times to try if SAP is online until it fails.
#!!#
########################################################################################################################
namespace: SAP.system.cmdline
flow:
  name: wait_for_sap_online
  inputs:
    - sap_connection: SAP
    - attempts: '10'
    - timeout: '10'
  workflow:
    - is_niping_tool_given:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(len(get_sp('sapdemo.niping')) > 0)}"
        navigate:
          - 'TRUE': is_sap_online_cmd
          - 'FALSE': is_sap_online_gui
    - is_sap_online_cmd:
        loop:
          for: 'seconds in range(0, int(attempts))'
          do:
            SAP.system.cmdline.is_sap_online:
              - seconds: '${str(2**int(seconds))}'
          break:
            - SUCCESS
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - is_sap_online_gui:
        do:
          SAP.system.is_sap_online:
            - sap_connection: '${sap_connection}'
            - attempts: '${attempts}'
            - timeout: '${timeout}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      is_niping_tool_given:
        x: 163
        'y': 253
      is_sap_online_cmd:
        x: 169
        'y': 81
        navigate:
          13de3821-244e-b7fc-ab32-c8350a336768:
            targetId: c654fbcc-70e4-da96-5caf-2630e9698147
            port: SUCCESS
      is_sap_online_gui:
        x: 341
        'y': 250
        navigate:
          82f6c7d5-4596-5466-6774-3bd204897d3e:
            targetId: c654fbcc-70e4-da96-5caf-2630e9698147
            port: SUCCESS
    results:
      SUCCESS:
        c654fbcc-70e4-da96-5caf-2630e9698147:
          x: 336
          'y': 85

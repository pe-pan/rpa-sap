namespace: SAP.system
flow:
  name: set_profile_parameter
  inputs:
    - sap_connection: INTERNAL
    - sap_admin_name: 'sap*'
    - sap_admin_password:
        default: Appl1ance
        sensitive: true
    - parameter_name: sapgui/user_scripting
    - parameter_value: 'FALSE'
  workflow:
    - set_profile_parameter_act:
        do:
          SAP.system.set_profile_parameter_act:
            - sap_connection: '${sap_connection}'
            - sap_admin_name: '${sap_admin_name}'
            - sap_admin_password: '${sap_admin_password}'
            - parameter_name: '${parameter_name}'
            - parameter_value: '${parameter_value}'
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      set_profile_parameter_act:
        x: 75
        'y': 90
        navigate:
          59a02c21-5494-c369-83a2-2ac480df48dd:
            targetId: 97d28b43-171c-594f-86f0-d6f0c19ee63b
            port: SUCCESS
          216ab583-2e42-be65-c21c-da3ac0398754:
            targetId: 97d28b43-171c-594f-86f0-d6f0c19ee63b
            port: WARNING
    results:
      SUCCESS:
        97d28b43-171c-594f-86f0-d6f0c19ee63b:
          x: 280
          'y': 95

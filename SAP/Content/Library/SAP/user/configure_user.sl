namespace: SAP.user
flow:
  name: configure_user
  workflow:
    - configure_user_act:
        do:
          SAP.user.configure_user_act: []
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
      configure_user_act:
        x: 130
        'y': 125
        navigate:
          06c84b8e-6e7c-9921-179e-578e70957331:
            targetId: 0f49006a-b098-5389-5225-1f69d37acdf9
            port: SUCCESS
          31b3620a-abec-5d39-144b-baa49f26decb:
            targetId: 0f49006a-b098-5389-5225-1f69d37acdf9
            port: WARNING
    results:
      SUCCESS:
        0f49006a-b098-5389-5225-1f69d37acdf9:
          x: 359
          'y': 127

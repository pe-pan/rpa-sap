namespace: SAP.Admin
flow:
  name: Set_User_Admin_flow
  inputs:
    - user_id
  workflow:
    - Set_User_Admin:
        do:
          SAP.Admin.Set_User_Admin:
            - user_id: '${user_id}'
        publish:
          - user_status
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - user_status: '${user_status}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Set_User_Admin:
        x: 187
        'y': 171
        navigate:
          ac6f0fc5-2864-9e47-461a-a6b7b9680e4e:
            targetId: ab95ec6d-77cd-083c-a297-e4f87e54384c
            port: SUCCESS
          74382dc0-7f93-e3dd-1add-87d9ce36aa6b:
            targetId: ab95ec6d-77cd-083c-a297-e4f87e54384c
            port: WARNING
    results:
      SUCCESS:
        ab95ec6d-77cd-083c-a297-e4f87e54384c:
          x: 409
          'y': 176

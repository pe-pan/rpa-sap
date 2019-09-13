########################################################################################################################
#!!
#! @description: Sets the given user as admin; attaches the SAP_ALL profile to the user.
#!!#
########################################################################################################################
namespace: SAP.user.admin
flow:
  name: set_admin
  inputs:
    - username
  workflow:
    - set_admin_act:
        do:
          SAP.user.admin.set_admin_act:
            - user_id: '${username}'
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
      set_admin_act:
        x: 186
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

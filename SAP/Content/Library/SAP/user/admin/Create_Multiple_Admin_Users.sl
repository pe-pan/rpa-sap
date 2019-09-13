namespace: SAP.Admin
flow:
  name: Create_Multiple_Admin_Users
  inputs:
    - username_prefix: user
    - start_index: '14'
    - last_index: '35'
    - first_name
    - last_name
    - email
    - password
  workflow:
    - Create_Admin_User_flow:
        loop:
          for: 'index in range(int(start_index), int(last_index)+1)'
          do:
            SAP.Admin.Create_Admin_User_flow:
              - username: '${username_prefix+str(index)}'
              - first_name: '${first_name}'
              - last_name: '${last_name}'
              - email: '${email}'
              - password: '${password}'
          break:
            - FAILURE
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Create_Admin_User_flow:
        x: 246
        'y': 168
        navigate:
          e3dd0956-4356-925c-c370-044275e90baf:
            targetId: 5402c148-a021-b61b-ee37-69f3068d569e
            port: SUCCESS
    results:
      SUCCESS:
        5402c148-a021-b61b-ee37-69f3068d569e:
          x: 414
          'y': 150

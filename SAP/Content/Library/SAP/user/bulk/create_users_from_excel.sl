########################################################################################################################
#!!
#! @description: Creates up to 1000 SAP users from given excel sheet. The sheet must have a header where each property is written in one column. Name (containing the first name and the last name) is in a single column; the names must be delimited by a white space character.
#!
#! @input name_header: Contains first name and last name delimited by space; if there is more such tokens; last name is the last one
#! @input set_admin: Attach the created users the SAP_ALL profile
#!!#
########################################################################################################################
namespace: SAP.user.bulk
flow:
  name: create_users_from_excel
  inputs:
    - excel_file: "C:\\Temp\\Excel.xlsx"
    - worksheet_name: Environment
    - username_header: SAP User
    - password_header: SAP Password
    - name_header: Name
    - email_header: E-mail
    - set_admin: 'true'
  workflow:
    - get_cell:
        do:
          io.cloudslang.base.excel.get_cell:
            - excel_file_name: '${excel_file}'
            - worksheet_name: '${worksheet_name}'
            - has_header: 'yes'
            - first_row_index: '0'
            - row_index: '0:1000'
            - column_index: '0:100'
        publish:
          - data: '${return_result}'
          - header
        navigate:
          - SUCCESS: row_to_map
          - FAILURE: on_failure
    - create_user_from_row:
        parallel_loop:
          for: "row in data.split('|')"
          do:
            SAP.user.bulk.subflows.create_user_from_row:
              - row: '${row}'
              - map: '${map}'
              - username_header: '${username_header}'
              - password_header: '${password_header}'
              - name_header: '${name_header}'
              - email_header: '${email_header}'
              - set_admin: '${set_admin}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - row_to_map:
        do:
          SAP.user.bulk.subflows.row_to_map:
            - row: '${header}'
        publish:
          - map
        navigate:
          - SUCCESS: create_user_from_row
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_cell:
        x: 67
        'y': 82
      create_user_from_row:
        x: 249
        'y': 258
        navigate:
          43d66b64-3366-a0b4-6e74-05b8c7ef10e4:
            targetId: 9756b875-cfa3-f1c3-af98-eab676df28eb
            port: SUCCESS
      row_to_map:
        x: 57
        'y': 261
    results:
      SUCCESS:
        9756b875-cfa3-f1c3-af98-eab676df28eb:
          x: 244
          'y': 78

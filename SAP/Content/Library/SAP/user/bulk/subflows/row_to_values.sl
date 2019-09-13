########################################################################################################################
#!!
#! @input row: values from one excel row
#! @input map: map with header_names -> column_indexes
#!!#
########################################################################################################################
namespace: SAP.user.bulk.subflows
operation:
  name: row_to_values
  inputs:
    - row
    - map
    - name_header
    - username_header
    - password_header
    - email_header
  python_action:
    script: |-
      import ast
      map=ast.literal_eval(map)

      a = row.split(',')
      name = a[map[name_header]].strip()
      username = a[map[username_header]].strip()
      password = a[map[password_header]].strip()
      email = a[map[email_header]].strip()

      a = name.split();
      first_name = a[0];
      last_name = a[len(a)-1]
  outputs:
    - name: '${name}'
    - username: '${username}'
    - password: '${password}'
    - first_name: '${first_name}'
    - last_name: '${last_name}'
    - email: '${email}'
  results:
    - SUCCESS

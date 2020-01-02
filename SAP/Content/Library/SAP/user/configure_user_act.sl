namespace: SAP.user
operation:
  name: configure_user_act
  inputs:
  - sap_connection
  - sap_admin_name
  - sap_admin_password
  - user_name
  - first_name
  - last_name
  - email
  - temp_password
  - password
  - title
  - academic_title
  - language
  - function
  - department
  - room
  - floor
  - building
  - phone
  - phone_ext
  - mobile
  - fax
  - fax_ext
  - method
  - start_menu
  - logon_language
  - decimal_notation
  - date_format
  - time_format
  - time_zone
  - profile
  outputs:
  - user_status:
      robot: true
      value: ${user_status}
  - user_password:
      robot: true
      value: ${user_password}
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:SAP.user.configure_user_act:1.0.0
    external: true
  results:
  - SUCCESS
  - WARNING
  - FAILURE

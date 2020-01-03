namespace: SAP.user
operation:
  name: configure_user_act
  inputs:
    - sap_connection
    - sap_admin_name
    - sap_admin_password
    - user_name
    - first_name:
        required: false
    - last_name:
        required: false
    - email:
        required: false
    - temp_password:
        required: false
    - password:
        required: false
    - title:
        required: false
    - academic_title:
        required: false
    - language:
        required: false
    - function:
        required: false
    - department:
        required: false
    - room:
        required: false
    - floor:
        required: false
    - building:
        required: false
    - phone:
        required: false
    - phone_ext:
        required: false
    - mobile:
        required: false
    - fax:
        required: false
    - fax_ext:
        required: false
    - method:
        required: false
    - start_menu:
        required: false
    - logon_language:
        required: false
    - decimal_notation:
        required: false
    - date_format:
        required: false
    - time_format:
        required: false
    - time_zone:
        required: false
    - profile:
        required: false
    - reuse_old_data:
        required: false
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

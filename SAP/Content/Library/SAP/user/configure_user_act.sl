namespace: SAP.user
operation:
  name: configure_user_act
  inputs:
  - sap_connection: INTERNAL
  - sap_admin_name: sap*
  - sap_admin_password:
      default: Appl1ance
      sensitive: true
  - user_name: admin15
  - first_name: Petrik
  - last_name: panusku
  - email: p@p.cz
  - temp_password:
      default: cloud1
      sensitive: true
  - password: cloud1
  - title: Ms.
  - academic_title: Dr.
  - language
  - function
  - department: Quality
  - room: '202'
  - floor: second
  - building: nowhere
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
  - profile: SAP_ALL
  - reuse_old_data: 'False'
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

namespace: SAP.user
flow:
  name: configure_user
  inputs:
    - sap_connection: 172.31.1.45
    - sap_admin_name: petr
    - sap_admin_password: Cloud@123
    - user_name: admin17
    - first_name:
        default: Petr
		required: false
    - last_name: Panuska
		default:
        required: false
    - email:
        default: sfsd@dfd.cz
        required: false
    - temp_password:
        required: false
    - password:
        default: Cloud@123
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
        default: '12334'
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
  workflow:
    - configure_user_act:
        do:
          SAP.user.configure_user_act:
            - sap_connection: '${sap_connection}'
            - sap_admin_name: '${sap_admin_name}'
            - sap_admin_password: '${sap_admin_password}'
            - user_name: '${user_name}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: "${get('email', '')}"
            - temp_password: "${get('temp_password', 'cloud1')}"
            - password: "${get('password', '')}"
            - title: "${get('title', '')}"
            - academic_title: "${get('academic_title', '')}"
            - language: "${get('language', '')}"
            - function: "${get('function', '')}"
            - department: "${get('department', '')}"
            - room: "${get('room', '')}"
            - floor: "${get('floor', '')}"
            - building: "${get('building', '')}"
            - phone: "${get('phone', '')}"
            - phone_ext: "${get('phone_ext', '')}"
            - mobile: "${get('mobile', '')}"
            - fax: "${get('fax', '')}"
            - fax_ext: "${get('fax_ext', '')}"
            - method: "${get('method', '')}"
            - start_menu: "${get('start_menu', '')}"
            - logon_language: "${get('logon_language', '')}"
            - decimal_notation: "${get('decimal_notation', '')}"
            - date_format: "${get('date_format', '')}"
            - time_format: "${get('time_format', '')}"
            - time_zone: "${get('time_zone', '')}"
            - profile: "${get('profile', '')}"
            - reuse_old_data: "${get('reuse_old_data', '')}"
        publish:
          - user_status
          - user_password
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - user_status: '${user_status}'
    - user_password: '${user_password}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
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

########################################################################################################################
#!!
#! @description: Creates a user or sets its properties if the user already exists. It can reuse old data (if the user has been deleted) and also set the permanent password.
#!
#! @input sap_connection: SAP connection description (in SAP GUI Logon client)
#! @input sap_admin_name: SAP user used to create the user (must have admin privileges)
#! @input sap_admin_password: SAP user password
#! @input user_name: User to be created or its properties changed
#! @input first_name: User first name
#! @input last_name: User last name; mandatory parameter when creating a new user
#! @input email: Valid e-mail
#! @input temp_password: Initial login password; will be changed upon first login; mandatory when creating a new user
#! @input password: Password set permanently. If given, temp_password must be also given.
#! @input profile: SAP_ALL for administration privileges
#! @input reuse_old_data: True / false to reuse previous data (the same user has been deleted before)
#! @input title: Mr. or Ms.
#! @input academic_title: Dr., Prof., Prof. Dr., B.A., MBA, Ph.D.
#! @input language: Arabic, Bulgarian, Catalan, Chinese, Croatian, Czech, etc.
#! @input function: Any piece of text
#! @input department: Any piece of text
#! @input room: Any piece of text
#! @input floor: Any piece of text
#! @input building: Any piece of text
#! @input phone: Any piece of text
#! @input phone_ext: Any piece of text
#! @input mobile: Any piece of text
#! @input fax: Fax number can not include country code
#! @input fax_ext: Any piece of text
#! @input method: E-mail, Fax, Pager/SMS, Post (letter), Printer, Remote Function Call, Remote Mail, Sales call, Secure Store & Forw., Telephone, Teletex, Telex, URL (Homepage), X.400
#! @input start_menu: /SAPPO/, AUTH, BALD, BALE, BALT, BUMR, etc.
#! @input logon_language: AF, AR, BG, CA, CS, DA, DE, EL, EN, ES, ET, FI, FR, HE, HI, HR HU, ID, IS, IT, JA, KK, etc.
#! @input decimal_notation: 1.234.567,89 or 1,234,567.89 or 1 234 567,89
#! @input date_format: DD.MM.YYYY (Gregorian Date), MM/DD/YYYY (Gregorian Date), MM-DD-YYYY (Gregorian Date), YYYY.MM.DD (Gregorian Date), etc.
#! @input time_format: 24 Hour Format (Example: 12:05:10), 12 Hour Format (Example: 12:05:10 PM), 12 Hour Forma (Example: 12:05:10 pm), Hours from 0 to 11 (Example: 00:05:10 PM), Hours from 0 to 11 (Example: 00:05:10 pm)
#! @input time_zone: AFGHAN, ALA, ALAW, AST, AUSACT, AUSLHI, AUSNSW, ... ,CET, ... ,EET, ..., EST, etc.
#!
#! @output user_status: User has been created or its details have been changed
#! @output user_password: User password; might be different from the input in case the input does not follow the password policy (is the same as one of the previous passwords)
#!!#
########################################################################################################################
namespace: SAP.user
flow:
  name: configure_user
  inputs:
    - sap_connection: INTERNAL
    - sap_admin_name: 'sap*'
    - sap_admin_password:
        default: Appl1ance
        sensitive: true
    - user_name: user001
    - first_name:
        default: First
        required: false
    - last_name:
        default: User
        required: false
    - email:
        required: false
    - temp_password:
        default: cloud1
        required: false
        sensitive: true
    - password:
        default: Cloud@123
        required: false
        sensitive: true
    - profile:
        required: false
    - reuse_old_data:
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
            - email: '${email}'
            - temp_password:
                value: '${temp_password}'
                sensitive: true
            - password:
                value: '${password}'
                sensitive: true
            - title: '${title}'
            - academic_title: '${academic_title}'
            - language: '${language}'
            - function: '${function}'
            - department: '${department}'
            - room: '${room}'
            - floor: '${floor}'
            - building: '${building}'
            - phone: '${phone}'
            - phone_ext: '${phone_ext}'
            - mobile: '${mobile}'
            - fax: '${fax}'
            - fax_ext: '${fax_ext}'
            - method: '${method}'
            - start_menu: '${start_menu}'
            - logon_language: '${logon_language}'
            - decimal_notation: '${decimal_notation}'
            - date_format: '${date_format}'
            - time_format: '${time_format}'
            - time_zone: '${time_zone}'
            - profile: '${profile}'
            - reuse_old_data: '${reuse_old_data}'
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
    - user_password:
        value: '${user_password}'
        sensitive: true
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

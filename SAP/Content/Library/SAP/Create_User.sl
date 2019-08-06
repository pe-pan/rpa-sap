namespace: SAP
operation:
  name: Create_User
  inputs:
    - username
    - first_name
    - last_name
    - email
    - password
  sequential_action:
    gav: 'com.microfocus.seq:SAP.Create_User:1.0.0'
    steps:
      - step:
          id: '1'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("SAP Easy Access")'
          action: Resize
          default_args: '103,25'
      - step:
          id: '2'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("SAP Easy Access").SAPGuiOKCode("OKCode")'
          action: Set
          default_args: '"su01"'
          snapshot: ".\\Snapshots\\ssf1.png"
          highlight_id: '21'
      - step:
          id: '3'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("SAP Easy Access")'
          action: SendKey
          default_args: ENTER
          snapshot: ".\\Snapshots\\ssf1.png"
          highlight_id: '0'
      - step:
          id: '4'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiEdit("User")'
          action: Set
          default_args: '"newuser4"'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '32'
          args: 'Parameter("username")'
      - step:
          id: '5'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiButton("Create   (F8)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '29'
      - step:
          id: '6'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("Last name")'
          action: Set
          default_args: '"user4"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '48'
          args: 'Parameter("last_name")'
      - step:
          id: '7'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("First name")'
          action: Set
          default_args: '"new"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '47'
          args: 'Parameter("first_name")'
      - step:
          id: '8'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("E-Mail Address")'
          action: Set
          default_args: '"nu@mf.com"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '44'
          args: 'Parameter("email")'
      - step:
          id: '9'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("E-Mail Address")'
          action: SetFocus
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '44'
      - step:
          id: '10'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiTabStrip("TABSTRIP1")'
          action: Select
          default_args: '"Logon Data"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '26'
      - step:
          id: '11'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("New Password")'
          action: Set
          default_args: '"********"'
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '42'
          args: 'Parameter("password")'
      - step:
          id: '12'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("Repeat Password")'
          action: Set
          default_args: '"********"'
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '43'
          args: 'Parameter("password")'
      - step:
          id: '13'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiEdit("Repeat Password")'
          action: SetFocus
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '43'
      - step:
          id: '14'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiButton("Save   (Ctrl+S)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '6'
      - step:
          id: '15'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Output
          default_args: 'CheckPoint("user_status")'
      - step:
          id: '16'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Sync
          snapshot: ".\\Snapshots\\ssf5.png"
          highlight_id: '1'
      - step:
          id: '17'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Sync
          snapshot: ".\\Snapshots\\ssf6.png"
          highlight_id: '1'
  outputs:
    - user_status:
        robot: true
        value: '${user_status}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

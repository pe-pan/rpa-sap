namespace: SAP.user.admin
operation:
  name: set_admin_act
  inputs:
    - user_id
  sequential_action:
    gav: 'com.microfocus.seq:SAP_Multiple_Admin_Users.Set_User_Admin:1.0.3'
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
          default_args: '"user012"'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '32'
          args: 'Parameter("user_id")'
      - step:
          id: '5'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiButton("Change   (Shift+F6)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '25'
      - step:
          id: '6'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiTabStrip("TABSTRIP1")'
          action: Select
          default_args: '"Profiles"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '27'
      - step:
          id: '7'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiGrid("Assigned Authorization")'
          action: SetCellData
          default_args: '1,"Profile","SAP_ALL"'
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '29'
      - step:
          id: '8'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Maintain Users").SAPGuiButton("Save   (Ctrl+S)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '6'
      - step:
          id: '9'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Sync
          snapshot: ".\\Snapshots\\ssf5.png"
          highlight_id: '1'
      - step:
          id: '10'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Output
          default_args: 'CheckPoint("user_status")'
      - step:
          id: '11'
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

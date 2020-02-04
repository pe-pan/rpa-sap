########################################################################################################################
#!!
#! @input user: Which user to reset password for
#! @input password: New password
#!!#
########################################################################################################################
namespace: SAP.user.reset
operation:
  name: reset_password_act
  inputs:
    - user
    - password
  sequential_action:
    gav: 'com.microfocus.seq:SAP_Reset_User_Password.Reset_User_Password:1.0.4'
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
          default_args: '"user41"'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '32'
          args: 'Parameter("user")'
      - step:
          id: '5'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiButton("Change Password   (Shift+F8)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '26'
      - step:
          id: '6'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Change Password").SAPGuiEdit("New Password")'
          action: Set
          default_args: '"********"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '12'
          args: 'Parameter("password")'
      - step:
          id: '7'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Change Password").SAPGuiEdit("Repeat Password")'
          action: Set
          default_args: '"********"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '13'
          args: 'Parameter("password")'
      - step:
          id: '8'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Change Password").SAPGuiEdit("Repeat Password")'
          action: SetFocus
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '13'
      - step:
          id: '9'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("Change Password").SAPGuiButton("Apply   (Enter)")'
          action: Click
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '2'
      - step:
          id: '10'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Sync
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '1'
      - step:
          id: '11'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Output
          default_args: 'CheckPoint("status")'
      - step:
          id: '12'
          object_path: 'SAPGuiSession("Session").SAPGuiWindow("User Maintenance: Initial").SAPGuiStatusBar("StatusBar")'
          action: Sync
          snapshot: ".\\Snapshots\\ssf5.png"
          highlight_id: '1'
  outputs:
    - status:
        robot: true
        value: '${status}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

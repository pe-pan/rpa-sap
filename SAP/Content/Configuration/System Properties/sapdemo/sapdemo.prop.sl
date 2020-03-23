########################################################################################################################
#!!
#! @system_property host: VM with SAP installation files where SAP is to be deployed
#! @system_property username: VM credentials
#! @system_property password: VM credentials
#! @system_property install_path: Path to SAP installation script
#! @system_property sap_os_password: Password of the linux users npladm and sybnpl (created during installation)
#! @system_property sap_connection: SAP GUI connection name used to connect to SAP server
#! @system_property sap_admin_name: Default SAP admin name
#! @system_property sap_admin_password: Default SAP admin password
#! @system_property company_name: Default company address used for newly created users
#! @system_property first_user_name: First admin user created
#! @system_property first_user_password: Password of the first admin user
#! @system_property niping: Full path to SAP niping tool (must be available on the worker where this flow is going to be 
#!                          executed).
#! @system_property port: SAP port where the client is connecting to
#! @system_property sap_os_username: SAP linux username
#!!#
########################################################################################################################
namespace: sapdemo
properties:
  - host:
      value: sapdemo.mf-te.com
      sensitive: false
  - username:
      value: centos
      sensitive: false
  - password:
      value: 'go.MF.admin123!'
      sensitive: true
  - install_path:
      value: /install/sapinst/install.sh
      sensitive: false
  - sap_os_password:
      value: Cloud123
      sensitive: true
  - sap_connection:
      value: INTERNAL
      sensitive: false
  - sap_admin_name:
      value: 'sap*'
      sensitive: false
  - sap_admin_password:
      value: Appl1ance
      sensitive: true
  - company_name:
      value: ITELO
      sensitive: false
  - first_user_name:
      value: admin
      sensitive: false
  - first_user_password:
      value: Cloud@123
      sensitive: true
  - niping:
      value: "C:\\\\Program Files (x86)\\\\SAP\\\\FrontEnd\\\\SAPgui\\\\niping.exe"
      sensitive: false
  - port:
      value: '3200'
      sensitive: false
  - sap_os_username:
      value: npladm
      sensitive: false

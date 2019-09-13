########################################################################################################################
#!!
#! @description: Creates a map out of a list. The list items will become map keys, the index of an item will be the value of the key.
#!               Example:
#!               input list: 'Prague, New York, Cluj, Bangalore'
#!               output map:
#!               { 'Prague' : 0,
#!               'New York' : 1,
#!               'Cluj': 2,
#!               'Bangalore' : 3
#!               }
#!
#! @input row: The list of unique values
#!
#! @output map: Keys contain the list items; values are indexes of the items
#!!#
########################################################################################################################
namespace: SAP.user.bulk.subflows
operation:
  name: row_to_map
  inputs:
    - row
  python_action:
    script: "list = row.split(\",\")\r\nmap = {}\r\nfor i, header in enumerate(list):\r\n  map[header.strip()] = i"
  outputs:
    - map: '${map}'
  results:
    - SUCCESS

SELECT
ics.ITEM_CLASS_NAME
, esi.ITEM_NUMBER AS "Item Code"
, esi.DESCRIPTION AS "Item Description"
, ium.UNIT_OF_MEASURE AS "Primary UOM"
, ioc.CONVERSION_RATE 
, esi.secondary_uom_code AS "Secondary UOM"
, iocc.TO_UOM_CODE 
, iocc.CONVERSION_RATE AS "intraclass conv"
, esi.secondary_uom_code AS "Secondary UOM2"
, iodv.ORGANIZATION_NAME AS "Organization Name"
, gcc.CONCATENATED_SEGMENTS AS "SALES Account"
, esi.PLANNER_CODE 
, esi.QTY_RCV_TOLERANCE 
, esi.CREATED_BY 
, esi.CREATION_DATE 
, esi.ENABLED_FLAG 
, CASE WHEN esi.LOT_CONTROL_CODE = 2 THEN 'Full Lot Control' ELSE 'No Control' END AS "Lot Control Status"
, esi.LOT_STATUS_ENABLED 
, esi.LOT_SPLIT_ENABLED  
, NULL AS "Item Template"
, NULL AS "Assigned Category IDs"
FROM
  EGP_SYSTEM_ITEMS_V esi
LEFT JOIN
  GL_CODE_COMBINATIONS gcc ON gcc.CODE_COMBINATION_ID = esi.SALES_ACCOUNT
JOIN
  EGP_ITEM_CLASSES_VL ics ON esi.ITEM_CATALOG_GROUP_ID = ics.ITEM_CLASS_ID 
JOIN
  INV_UNITS_OF_MEASURE_VL ium ON esi.PRIMARY_UOM_CODE = ium.UOM_CODE
JOIN 
  inv_organization_definitions_v iodv ON iodv.ORGANIZATION_ID = esi.ORGANIZATION_ID
LEFT JOIN
  inv_uom_conversions ioc ON esi.inventory_item_id = ioc.inventory_item_id
  AND esi.primary_uom_code = ioc.uom_code
LEFT JOIN
  inv_uom_class_conversions iocc ON esi.inventory_item_id = iocc.inventory_item_id
  AND ioc.uom_class = iocc.from_uom_class
WHERE
 esi.ORGANIZATION_ID IS NOT NULL
 -- Filter for prefix A3-
 -- AND esi.ITEM_NUMBER LIKE 'B3-%'
 -- AND esi.ITEM_NUMBER = 'F3-43110029'
 -- Filter for specific Organization Names
 AND iodv.ORGANIZATION_NAME = 'SKLT MASTER'
 -- AND iodv.ORGANIZATION_NAME IN ('E-COMMERCE SURABAYA', 'E-COMMERCE JAKARTA', 'E-COMMERCE MEDAN', 'FINNA GIFT SHOP SURABAYA', 'FINNA GIFT SHOP PASAR SENEN')
 -- AND esi.inventory_item_id = '100000003112817'
ORDER BY
esi.ITEM_NUMBER ASC

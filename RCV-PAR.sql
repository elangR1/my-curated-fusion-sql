-- Check Manage Receiving Parameters
SELECT 
    iod.organization_code,
    iod.organization_name,
    rp.days_early_receipt_allowed AS early_tolerance_days,
    rp.days_late_receipt_allowed AS late_tolerance_days,
    rp.receipt_days_exception_code AS receipt_days_action,
    rp.qty_rcv_tolerance AS over_receipt_tolerance_percent,
    rp.qty_rcv_exception_code AS over_receipt_action
FROM 
    rcv_parameters rp
JOIN 
    inv_organization_definitions_v iod ON rp.organization_id = iod.organization_id
ORDER BY 
    iod.organization_code ASC;
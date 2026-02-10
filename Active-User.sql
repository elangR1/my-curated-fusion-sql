-- active user
SELECT 
    pu.username,
    pu.active_flag, 
    pu.suspended,
    pu.start_date ,
    CASE 
        WHEN pu.active_flag = 'Y' AND pu.suspended = 'N' THEN 'Active'
        WHEN pu.active_flag = 'N' THEN 'Inactive'
        WHEN pu.suspended = 'Y' THEN 'Locked/Suspended'
        ELSE 'Unknown'
    END AS account_status
FROM 
    per_users pu
WHERE 
    pu.username NOT LIKE 'FUSION_APP%' AND 
    pu.username NOT LIKE 'FACP%' AND
    pu.username NOT LIKE 'urn_opc%' AND
    pu.username NOT LIKE 'PSCR_%'
ORDER BY 
    pu.username ASC
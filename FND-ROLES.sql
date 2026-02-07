-- Check User Roles
SELECT
    pu.username,
    prdv.role_name,
    prdv.role_common_name, -- Seringkali nama yang lebih deskriptif
    pur.start_date,
    pur.end_date
FROM
    per_user_roles pur
JOIN
    per_users pu ON pur.user_id = pu.user_id
JOIN
    per_roles_dn_vl prdv ON pur.role_id = prdv.role_id
WHERE
    pu.username = 'ad-fsn'  -- Ganti dengan username yang relevan
AND TRUNC(SYSDATE) BETWEEN pur.start_date AND NVL(pur.end_date, TO_DATE('4712-12-31', 'YYYY-MM-DD'));
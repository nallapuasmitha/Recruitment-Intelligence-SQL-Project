
USE recruitment_intelligence;

SELECT
    current_stage,
    COUNT(*) AS total_candidates,
    SUM(
        CASE
            WHEN application_status = 'Hired' THEN 1
            ELSE 0
        END
    ) AS hired_count,
    SUM(
        CASE
            WHEN application_status = 'Rejected' THEN 1
            ELSE 0
        END
    ) AS rejected_count
FROM applications
GROUP BY current_stage
ORDER BY total_candidates DESC;

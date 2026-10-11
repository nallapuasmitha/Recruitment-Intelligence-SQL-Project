USE recruitment_intelligence;

SELECT
    j.job_title,
    j.department,
    COUNT(a.application_id) AS total_applications,
    SUM(
        CASE
            WHEN a.application_status = 'Hired' THEN 1
            ELSE 0
        END
    ) AS total_hired,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.application_status = 'Hired' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(a.application_id), 0),
        2
    ) AS hiring_rate_percentage
FROM jobs j
LEFT JOIN applications a
    ON j.job_id = a.job_id
GROUP BY j.job_id, j.job_title, j.department
ORDER BY hiring_rate_percentage DESC;
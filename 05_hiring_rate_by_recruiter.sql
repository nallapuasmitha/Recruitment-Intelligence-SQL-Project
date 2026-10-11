USE recruitment_intelligence;

SELECT
    r.recruiter_id,
    r.recruiter_name,
    r.department,
    COUNT(DISTINCT j.job_id) AS jobs_handled,
    COUNT(a.application_id) AS total_applications,
    SUM(
        CASE
            WHEN a.application_status = 'Hired' THEN 1
            ELSE 0
        END
    ) AS successful_hires,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.application_status = 'Hired' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(a.application_id), 0),
        2
    ) AS hiring_rate_percentage
FROM recruiters r
LEFT JOIN jobs j
    ON r.recruiter_id = j.recruiter_id
LEFT JOIN applications a
    ON j.job_id = a.job_id
GROUP BY
    r.recruiter_id,
    r.recruiter_name,
    r.department
ORDER BY successful_hires DESC, total_applications DESC;
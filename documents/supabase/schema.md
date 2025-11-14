| table_name        | column_name       | data_type                | is_nullable |
| ----------------- | ----------------- | ------------------------ | ----------- |
| qr_scans          | id                | bigint                   | NO          |
| qr_scans          | qr_code           | text                     | NO          |
| qr_scans          | scanned_at        | timestamp with time zone | YES         |
| qr_scans          | user_agent        | text                     | YES         |
| qr_scans          | ip_address        | text                     | YES         |
| qr_scans          | created_at        | timestamp with time zone | YES         |
| vendors           | id                | uuid                     | NO          |
| vendors           | vendor_name       | text                     | NO          |
| vendors           | booth_number      | text                     | YES         |
| vendors           | qr_code           | text                     | YES         |
| vendors           | created_at        | timestamp with time zone | YES         |
| visitors          | id                | uuid                     | NO          |
| visitors          | name              | text                     | NO          |
| visitors          | phone             | text                     | NO          |
| visitors          | email             | text                     | YES         |
| visitors          | gender            | text                     | YES         |
| visitors          | age_group         | text                     | YES         |
| visitors          | country           | text                     | YES         |
| visitors          | state             | text                     | YES         |
| visitors          | salary_group      | text                     | YES         |
| visitors          | interest          | text                     | YES         |
| visitors          | consent           | boolean                  | YES         |
| visitors          | pass_url          | text                     | YES         |
| visitors          | total_points      | integer                  | YES         |
| visitors          | created_at        | timestamp with time zone | YES         |
| visits            | id                | uuid                     | NO          |
| visits            | vendor_id         | uuid                     | YES         |
| visits            | visitor_id        | uuid                     | YES         |
| visits            | scan_timestamp    | timestamp with time zone | YES         |
| visits            | points_awarded    | integer                  | YES         |
| visits            | visit_count       | integer                  | YES         |
| whatsapp_sessions | id                | uuid                     | NO          |
| whatsapp_sessions | visitor_phone     | text                     | NO          |
| whatsapp_sessions | session_initiated | boolean                  | YES         |
| whatsapp_sessions | initiated_at      | timestamp with time zone | YES         |
| whatsapp_sessions | last_activity     | timestamp with time zone | YES         |
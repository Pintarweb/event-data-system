# Visits Table Workflow Update

## Overview
The QR Entry Router workflow needs to be updated to handle visits with unique constraints and visit count increments.

## Required Changes to QR Entry Router Workflow

### After "Code in JavaScript" node (before "Update a row" for visitors):

1. **Add "Check Existing Visit" node** (Supabase Get operation):
   - Table: `visits`
   - Filter: `visitor_id = {{ $json.visit_visitor_id }}` AND `vendor_id = {{ $json.visit_vendor_id }}`
   - Always output data: true

2. **Add "Handle Visit" node** (Code/Function):
   ```javascript
   const existingVisit = $input.first().json;
   const visitData = $('Code in JavaScript').first().json;
   
   if (existingVisit && existingVisit.id) {
     // Visit exists - increment count
     return [{
       json: {
         ...visitData,
         visit_exists: true,
         visit_id: existingVisit.id,
         current_visit_count: existingVisit.visit_count || 1,
         new_visit_count: (existingVisit.visit_count || 1) + 1
       }
     }];
   } else {
     // Visit doesn't exist - create new
     return [{
       json: {
         ...visitData,
         visit_exists: false,
         visit_count: 1
       }
     }];
   }
   ```

3. **Add "Upsert Visit" node** (Supabase):
   - If visit_exists: Update operation
     - Table: `visits`
     - Filter: `id = {{ $json.visit_id }}`
     - Fields: `visit_count = {{ $json.new_visit_count }}`, `scan_timestamp = {{ $json.scan_timestamp }}`
   - If not visit_exists: Create operation
     - Table: `visits`
     - Fields: `visitor_id`, `vendor_id`, `scan_timestamp`, `points_awarded`, `visit_count`

### Alternative: Use Supabase Upsert (if supported)
- Operation: Upsert
- Table: `visits`
- Conflict on: `visitor_id, vendor_id`
- On conflict: Update `visit_count = visit_count + 1`, `scan_timestamp = NOW()`
- On no conflict: Insert new record with `visit_count = 1`

## Database Schema
- `visits.visit_count` (INTEGER, default 1)
- Unique constraint: `(visitor_id, vendor_id)`

## Notes
- The unique constraint ensures visitor A can only visit vendor X once (one record per combination)
- Each scan increments the `visit_count` for that visitor-vendor pair
- First visit creates the record with `visit_count = 1`
- Subsequent visits increment the count


# Visitor Registration Updates - Summary

## Overview
Updated the visitor registration system to include comprehensive demographic data collection, data protection consent, and improved visit tracking.

## Changes Made

### 1. Visitor Registration Form (`docs/visitor-register.html`)

#### New Fields Added:
- **Gender** (Radio buttons): Male / Female / Prefer Not to Say
- **Age Group** (Radio buttons): 
  - Less than 18 years
  - 18-24 years
  - 25-34 years
  - 35-44 years
  - 45-54 years
  - More than 55 years
- **Country of Origin** (Searchable dropdown): Default "Malaysia", includes 20+ countries
- **State of Origin** (Dropdown): Enabled only when Country is "Malaysia"
  - All 13 states + 3 Federal Territories
- **Monthly Salary Group** (Radio buttons):
  - Less than RM2,000
  - RM2,001-RM5,000
  - RM5,001-RM10,000
  - More than RM10,000
- **Interest** (Multi-select checkboxes):
  - Technology
  - Fashion
  - Business
  - Food and Beverage
  - Travel
  - Health
  - Agriculture
  - Others (with text input field)

#### Data Protection & Consent Section:
- Comprehensive PDPA 2010 compliance notice
- Three consent points:
  1. Data processing consent
  2. Anonymous aggregation consent
  3. Vendor communication consent
- Required checkbox to proceed with registration

#### JavaScript Enhancements:
- Country/State conditional logic (state enabled only for Malaysia)
- "Others" interest field show/hide logic
- Multi-select interest collection and validation
- Consent checkbox validation
- All form data properly collected and formatted for API

### 2. Supabase Schema Updates

#### Visitors Table - New Columns:
- `gender` (text, nullable)
- `age_group` (text, nullable)
- `country` (text, nullable)
- `state` (text, nullable)
- `salary_group` (text, nullable)
- `interest` (text, nullable) - stores comma-separated values
- `consent` (boolean, nullable)

#### Visits Table - New Column:
- `visit_count` (integer, nullable, default 1)

#### Required Database Changes:
- Run `supabase/visits_table_update.sql` to:
  - Add `visit_count` column
  - Add unique constraint on `(visitor_id, vendor_id)`
  - Create index for faster lookups

### 3. n8n Workflow Updates

#### Visitor Registration Workflow (`documents/n8n/Visitor Registration.json`):
- Updated "Process Form Data1" node to extract all new fields
- Updated "Create New Visitor" node to include all new field mappings:
  - gender, age_group, country, state, salary_group, interest, consent

#### QR Entry Router Workflow (`documents/n8n/QR Entry Router.json`):
- Updated "Code in JavaScript" node to prepare visit data
- **Note**: Additional nodes needed for visit tracking (see `docs/visits_workflow_update.md`)

### 4. Visit Tracking System

#### Requirements:
- Unique constraint on `(visitor_id, vendor_id)` ensures one record per visitor-vendor pair
- `visit_count` increments with each scan
- First visit creates record with `visit_count = 1`
- Subsequent visits increment the count

#### Implementation Guide:
See `docs/visits_workflow_update.md` for detailed workflow update instructions.

## Files Modified

1. `docs/visitor-register.html` - Complete form overhaul
2. `supabase/schema.md` - Schema documentation updated
3. `documents/supabase/schema.md` - Schema documentation updated
4. `documents/n8n/Visitor Registration.json` - Workflow updated
5. `documents/n8n/QR Entry Router.json` - Workflow updated (partial)

## Files Created

1. `supabase/visits_table_update.sql` - SQL script for database updates
2. `docs/visits_workflow_update.md` - Workflow update instructions
3. `docs/visitor_registration_updates_summary.md` - This file

## Next Steps

1. **Database Setup**:
   - Run `supabase/visits_table_update.sql` in Supabase SQL Editor
   - Add new columns to `visitors` table in Supabase dashboard

2. **n8n Workflow Updates**:
   - Import updated `Visitor Registration.json` workflow
   - Follow instructions in `visits_workflow_update.md` to complete QR Entry Router updates

3. **Testing**:
   - Test form submission with all new fields
   - Verify data is saved correctly in Supabase
   - Test visit tracking with unique constraint
   - Verify visit count increments correctly

4. **Validation**:
   - Ensure consent checkbox is required
   - Verify state field is disabled for non-Malaysia countries
   - Test "Others" interest field appears when selected
   - Verify at least one interest must be selected

## Notes

- Form maintains backward compatibility with existing duplicate detection
- All new fields are optional except where marked with *
- Interest field stores comma-separated values (e.g., "Technology,Fashion,Business")
- "Others" interest includes specification in format: "Others: [user input]"
- Consent is stored as boolean in database
- Visit tracking ensures data integrity with unique constraints


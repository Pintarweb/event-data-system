-- Update visits table to add visit_count and unique constraint
-- Run this in Supabase SQL Editor

-- Add visit_count column if it doesn't exist
ALTER TABLE visits 
ADD COLUMN IF NOT EXISTS visit_count INTEGER DEFAULT 1;

-- Create unique constraint on (visitor_id, vendor_id) if it doesn't exist
-- This ensures a visitor can only have one visit record per vendor
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_visitor_vendor_visit'
    ) THEN
        ALTER TABLE visits 
        ADD CONSTRAINT unique_visitor_vendor_visit 
        UNIQUE (visitor_id, vendor_id);
    END IF;
END $$;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_visits_visitor_vendor 
ON visits(visitor_id, vendor_id);

-- Update existing records to have visit_count = 1 if NULL
UPDATE visits 
SET visit_count = 1 
WHERE visit_count IS NULL;


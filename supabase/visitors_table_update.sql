-- Update visitors table to add new demographic and consent fields
-- Run this in Supabase SQL Editor

-- Add gender column
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS gender TEXT;

-- Add age_group column
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS age_group TEXT;

-- Add country column
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS country TEXT;

-- Add state column
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS state TEXT;

-- Add salary_group column
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS salary_group TEXT;

-- Add interest column (stores comma-separated values)
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS interest TEXT;

-- Add consent column (boolean)
ALTER TABLE visitors 
ADD COLUMN IF NOT EXISTS consent BOOLEAN;

-- Optional: Add comments to document the columns
COMMENT ON COLUMN visitors.gender IS 'Visitor gender: Male, Female, or Prefer Not to Say';
COMMENT ON COLUMN visitors.age_group IS 'Visitor age group: less than 18 years, 18-24 years, 25-34 years, 35-44 years, 45-54 years, more than 55 years';
COMMENT ON COLUMN visitors.country IS 'Country of origin';
COMMENT ON COLUMN visitors.state IS 'State of origin (only applicable if country is Malaysia)';
COMMENT ON COLUMN visitors.salary_group IS 'Monthly salary group: less than RM2,000, RM2,001-RM5,000, RM5,001-RM10,000, more than RM10,000';
COMMENT ON COLUMN visitors.interest IS 'Comma-separated list of interests: Technology, Fashion, Business, Food and Beverage, Travel, Health, Agriculture, Others';
COMMENT ON COLUMN visitors.consent IS 'Data protection consent agreement (PDPA 2010)';

-- Verify the columns were added successfully
SELECT 
    column_name, 
    data_type, 
    is_nullable
FROM information_schema.columns
WHERE table_name = 'visitors'
ORDER BY ordinal_position;


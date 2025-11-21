-- Add certificate_url column to vendors table
ALTER TABLE vendors 
ADD COLUMN IF NOT EXISTS certificate_url text;

-- Add comment
COMMENT ON COLUMN vendors.certificate_url IS 'URL to the generated registration certificate';

-- Add missing columns to vendors table
ALTER TABLE vendors 
ADD COLUMN IF NOT EXISTS business_type text,
ADD COLUMN IF NOT EXISTS contact_person text,
ADD COLUMN IF NOT EXISTS designation text,
ADD COLUMN IF NOT EXISTS contact_phone text,
ADD COLUMN IF NOT EXISTS email text,
ADD COLUMN IF NOT EXISTS company_website text,
ADD COLUMN IF NOT EXISTS certificate_url text;

-- Add constraints safely
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vendors_contact_phone_key') THEN
        ALTER TABLE vendors ADD CONSTRAINT vendors_contact_phone_key UNIQUE (contact_phone);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vendors_email_key') THEN
        ALTER TABLE vendors ADD CONSTRAINT vendors_email_key UNIQUE (email);
    END IF;
END $$;

-- Create Storage Bucket for Certificates
INSERT INTO storage.buckets (id, name, public) 
VALUES ('certificates', 'certificates', true)
ON CONFLICT (id) DO NOTHING;

-- Add RLS policies safely
DO $$
BEGIN
    -- Drop existing policies to ensure we can recreate them
    DROP POLICY IF EXISTS "Public Access" ON storage.objects;
    DROP POLICY IF EXISTS "Public Upload" ON storage.objects;
    
    CREATE POLICY "Public Access" ON storage.objects FOR SELECT USING ( bucket_id = 'certificates' );
    CREATE POLICY "Public Upload" ON storage.objects FOR INSERT WITH CHECK ( bucket_id = 'certificates' );
END $$;

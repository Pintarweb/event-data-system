# EVENT DATA COLLECTION SYSTEM - PROJECT CONTEXT

## 🏗️ CURRENT INFRASTRUCTURE
**GitHub Repository:** https://github.com/Pintarweb/event-data-system
**Supabase Project:** udueffcragmnsqcccixs
**n8n Instance:** https://n8n.pintarweb.com
**Database Status:** ✅ 4 core tables created
**Current Phase:** Week 1, Day 1 Complete

## 🎯 PROJECT OVERVIEW
**Primary Goal:** Track visitor-vendor interactions at mass public events via QR codes
**Target Scale:** 200-500 vendors, 5,000-20,000 visitors per event
**Tech Stack:** n8n + Supabase + WhatsApp Cloud API + Static HTML

## 📊 DATABASE SCHEMA
```sql
-- Core tables created:
-- vendors (id, vendor_name, booth_number, qr_code, created_at)
-- visitors (id, name, phone, email, pass_url, total_points, created_at)
-- visits (id, vendor_id, visitor_id, scan_timestamp, points_awarded)
-- whatsapp_sessions (id, visitor_phone, session_initiated, initiated_at)

## 🗓️ DEVELOPMENT STATUS
**Day 2 Complete:** All 3 core webhooks built and tested
**Current Phase:** Ready for database integration
**Next:** Day 3 - Connect webhooks to Supabase

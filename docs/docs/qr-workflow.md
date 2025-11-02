# QR Entry Router Workflow - Final Design

## 🎯 Purpose
Intelligent routing for QR code scans at vendor booths

## 🔗 Endpoint
`GET https://n8n.pintarweb.com/webhook/qr-scan?vendor_id=V123&visitor_id=VIS456`

## 🔄 Workflow Flow
QR Scan → Function Node → Supabase Vendor Lookup → Combine Function → Switch Node → 3 Routes

## 🧩 Node Details

### 1. Webhook Node
- **Method:** GET
- **Path:** `/webhook/qr-scan`
- **Parameters:** 
  - `vendor_id` (required)
  - `visitor_id` (optional)

### 2. Function Node (QR Processor)
```javascript
// Extract parameters from QR scan
const vendorId = $input.query.vendor_id;
const visitorId = $input.query.visitor_id;

return [
  {
    json: {
      vendor_id: vendorId,
      visitor_id: visitorId,
      scan_time: new Date().toISOString()
    }
  }
];
```

### 3. Supabase Node (Vendor Lookup)
Operation: Get Many

Table: `vendors`

Filter: `id` = `{{ $json.vendor_id }}`

Options: Always Output Data = true

### 4. Function Node (Combine & Route Logic)
```javascript
// Combine data and determine routing
const qrData = $input[0].json;
const vendorData = $input[1]?.json || {};

let route = '';
if (!vendorData.id) {
  route = 'vendor_not_found';
} else if (!qrData.visitor_id) {
  route = 'new_visitor';
} else {
  route = 'returning_visitor';
}

return [
  {
    json: {
      route: route,
      vendor_id: qrData.vendor_id,
      visitor_id: qrData.visitor_id,
      vendor_exists: !!vendorData.id,
      vendor_name: vendorData.vendor_name,
      timestamp: new Date().toISOString()
    }
  }
];
```
### 5. Switch Node (3-Way Routing)

#### Rule 1: Vendor Not Found
`{{ $json.route }} = "vendor_not_found"`

Action: Show error page

#### Rule 2: New Visitor

text
`{{ $json.route }} = "new_visitor"`

Action: Redirect to registration form

#### Rule 3: Returning Visitor

text
`{{ $json.route }} = "returning_visitor"`

Action: Quick check-in + redirect to pass

## 🎯 Routing Logic
Scenario	Vendor Exists	Visitor ID	Route	Action
Invalid Vendor	❌	Any	vendor_not_found	Error page
First Visit	✅	❌	new_visitor	Registration form
Returning	✅	✅	returning_visitor	Quick check-in


## 🔗 Live URLs
Registration Form: `https://pintarweb.github.io/event-data-system/visitor-register.html`

Visitor Pass: `https://pintarweb.github.io/event-data-system/pass.html`

## 💡 Key Design Decisions
Single Function Pattern - All routing logic in one place (proven from WhatsApp workflow)

Vendor Validation - Ensures QR codes point to real vendors

Visitor Trust - Visitor IDs from our system are trusted (already validated during registration)

Clean Routing - Simple 3-way switch based on pre-computed route

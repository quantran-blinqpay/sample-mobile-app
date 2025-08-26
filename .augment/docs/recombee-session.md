# API Reference

## Get session recombee
- **Endpoint**: `GET /api/recombee/session`
- **Header**:
  - `Accept` = "application/vnd.dw.v1.4+json", 
  - `User-Agent` = "kWXVDsQ7zJ98EYEGoLZmWThdWSwyt6GG", 
- **Query Params**:
  - `scenario` (String) - at this time use default (default is "you_may_like_homepage")
  - `locale` (String) - at this time use default (default is "NZ")
- **Response Example**:
```json
{
  "success": true,
  "session_id": "3fcd394a-4993-423f-b414-9c8aa65842f9"
}


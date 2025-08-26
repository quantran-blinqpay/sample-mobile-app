# API Reference

## Get recommend next item (Paginated)
- **Endpoint**: `GET /api/recombee/recommend-next-items`
- **Header**:
  - `Accept` = "application/vnd.dw.v1.4+json", 
  - `User-Agent` = "kWXVDsQ7zJ98EYEGoLZmWThdWSwyt6GG", 
- **Query Params**:
  - `recomm_id` (String) - use "recommId" field from response of /api/recombee/recommend-items endpoint.
- **Response Example**:
```json
{
  "recommId": "fd57c7af71c240bb1985e08adbe85323",
  "recomms": [
    {
      "id": "3345339",
      "values": {
        "alt_sizes": [
          "2XL",
          "L",
          "XL"
        ],
        "brand": "Juliette Hogan",
        "brand_id": "832",
        "brand_slug": "juliette-hogan",
        "can_ship_to_au": true,
        "can_ship_to_nz": true,
        "category": "Dresses",
        "category_id": 11,
        "cio_image_url": "https://dwcdn.nz/dw-images/Loveworn/3345339/98ea4f7606c9782ef232e1b71ae105ee.jpg/search",
        "colors": [
          "Pink",
          "Various"
        ],
        "created_at": 1752539602,
        "description": "This is a beautiful ‘Floral Falls’ print silk viscose dress from Juliette Hogan that retailed at around $749.\n\nIt’s a stunning long dress featuring a tiered skirt and drawstring waist. Fastens with a button at the back.\n\nIt’s made of a superb silk viscose blend fabric in Hogan’s iconic abstract ‘Floral Falls’ print.\n\nSize: 14 (flexible fit)\nCondition: very good",
        "generic_sizes": [
          "16",
          "14",
          "12"
        ],
        "image_url": "https://dwcdn.nz/dw-images/Loveworn/3345339/98ea4f7606c9782ef232e1b71ae105ee.jpg",
        "is_available": true,
        "location": "NZ",
        "number_of_watchers": 30,
        "original_price": 400.5,
        "parent_categories": [
          "women"
        ],
        "price_aud": 337.44,
        "price_nzd": 355.5,
        "price_pattern_currency": "nzd",
        "renewed_at": 1752539602,
        "sale_price_au": 380.5,
        "sale_price_nz": 365,
        "sale_price_without_shipping_fee": 355.5,
        "seller_id": "123968",
        "shipping_to_au_amount": 25,
        "shipping_to_au_currency": "NZD",
        "shipping_to_nz_amount": 9.5,
        "shipping_to_nz_currency": "NZD",
        "sizes_str": "14 / XL, 12 / L, 16 / 2XL",
        "title": "Juliette Hogan Dress Floral - 12, 14",
        "url": "https://nz2-staging.designerwardrobe.co.nz/listings/3345339/beautiful-juliette-hogan-silk-viscose-floral-falls-print-long-dress-749",
        "url_title": "beautiful-juliette-hogan-silk-viscose-floral-falls-print-long-dress-749"
      }
    },
    {
      "id": "2937319",
      "values": {
        "alt_sizes": [
          "M",
          "S"
        ],
        "brand": "MAX",
        "brand_id": "2270",
        "brand_slug": "max",
        "can_ship_to_au": true,
        "can_ship_to_nz": true,
        "category": "Shirts",
        "category_id": 14,
        "cio_image_url": "https://dwcdn.nz/dw-images/ashtur95/2937319/96fe74fd96bf0dff610a8aae4d27606e.jpg/search",
        "colors": [
          "White"
        ],
        "created_at": 1733857974,
        "description": "Great for work, just needs an iron but in great condition.",
        "generic_sizes": [
          "10",
          "8"
        ],
        "image_url": "https://dwcdn.nz/dw-images/ashtur95/2937319/96fe74fd96bf0dff610a8aae4d27606e.jpg",
        "is_available": false,
        "location": "NZ",
        "number_of_watchers": 7,
        "original_price": 35,
        "parent_categories": [
          "womens-tops",
          "women"
        ],
        "price_aud": 37.489999999999995,
        "price_nzd": 25,
        "price_pattern_currency": "nzd",
        "renewed_at": 1739313822,
        "sale_price_au": 50,
        "sale_price_nz": 25,
        "sale_price_without_shipping_fee": 25,
        "seller_id": "129178",
        "shipping_to_au_amount": 25,
        "shipping_to_au_currency": "NZD",
        "shipping_to_nz_amount": 0,
        "shipping_to_nz_currency": "NZD",
        "sizes_str": "8 / S, 10 / M",
        "title": "MAX Blouse White - 8, 10",
        "url": "https://nz5-staging.designerwardrobe.co.nz/listings/2937319/white-max-blouse",
        "url_title": "white-max-blouse"
      }
    }
  ],
  "numberNextRecommsCalls": 0
}
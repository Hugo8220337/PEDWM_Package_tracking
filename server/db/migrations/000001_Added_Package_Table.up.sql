CREATE TYPE tracking_status AS ENUM ('pending', 'in_transit', 'delivered', 'returned');

CREATE TABLE package (
    id SERIAL PRIMARY KEY,
    tracking_number VARCHAR(255) NOT NULL UNIQUE,
    status tracking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
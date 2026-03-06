CREATE TABLE tracking_event (
    id SERIAL PRIMARY KEY,
    package_id INT REFERENCES package(id) ON DELETE CASCADE,
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(255),
    status tracking_status NOT NULL
);
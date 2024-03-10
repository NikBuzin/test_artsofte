ATTACH TABLE _ UUID 'e2915efa-74bc-4e86-99bb-53ee024dcd99'
(
    `id` UInt64,
    `value` Float64,
    `client_id` UInt64,
    `client_name` String,
    `payment_date` Date,
    `manager_name` Nullable(String),
    `manager_email` Nullable(String)
)
ENGINE = MergeTree
ORDER BY id
SETTINGS index_granularity = 8192

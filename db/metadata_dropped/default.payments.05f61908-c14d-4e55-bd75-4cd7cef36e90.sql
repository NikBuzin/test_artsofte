ATTACH TABLE _ UUID '05f61908-c14d-4e55-bd75-4cd7cef36e90'
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

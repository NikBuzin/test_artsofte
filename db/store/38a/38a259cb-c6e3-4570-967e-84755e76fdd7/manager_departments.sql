ATTACH TABLE _ UUID '154764d2-69a1-4e12-b892-7d3e1537903a'
(
    `email` String,
    `department` Nullable(String)
)
ENGINE = MergeTree
ORDER BY email
SETTINGS index_granularity = 8192

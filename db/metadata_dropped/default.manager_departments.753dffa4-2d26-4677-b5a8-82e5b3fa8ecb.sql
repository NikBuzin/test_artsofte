ATTACH TABLE _ UUID '753dffa4-2d26-4677-b5a8-82e5b3fa8ecb'
(
    `email` String,
    `department` Nullable(String)
)
ENGINE = MergeTree
ORDER BY email
SETTINGS index_granularity = 8192

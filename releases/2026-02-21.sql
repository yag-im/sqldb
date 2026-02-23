-- convert uuidv4 to uuidv7

ALTER TABLE games.releases ADD COLUMN uuidv4 UUID UNIQUE NULL;

UPDATE games.releases SET uuidv4 = uuid::uuid WHERE ts_added < '2026-02-19 20:30:05.000000';

UPDATE games.releases
SET uuid = (
    -- 1. Timestamp: chars 1-12
    lpad(to_hex((extract(epoch from ts_added) * 1000)::bigint), 12, '0') ||
    -- 2. Version: The 13th character MUST be '7'
    '7' ||
    -- 3. Rand_A: Keep original characters 14, 15, 16
    substring(replace(uuid::text, '-', '') from 14 for 3) ||
    -- 4. Variant: Take the 17th character and force top 2 bits to '10'
    to_hex(((('x' || substring(replace(uuid::text, '-', '') from 17 for 1))::bit(4) & b'0011') | b'1000')::int) ||
    -- 5. Rand_B: Keep characters 18 through 32
    substring(replace(uuid::text, '-', '') from 18)
    )::uuid;

ALTER TABLE games.releases DROP COLUMN ts_added;

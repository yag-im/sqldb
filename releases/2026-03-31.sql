/*
-- local env
ALTER TYPE cluster.node_flavor ADD VALUE 'custom-1';

INSERT INTO cluster.nodes(uuid, region, service_type, node_ix, node_type, node_flavor, created_ts)
VALUES (
    'f973b9a3-2d9b-4168-bbff-a9fa1d1bc5dc',
    'us-west-1',
    'jukebox',
    0, -- '172.17.0.1'
    'dedicated',
    'custom-1',
    '2026-01-01 00:00:00');
*/

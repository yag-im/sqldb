UPDATE games.releases
SET runner = jsonb_set(runner :: JSONB, '{ver}', '"2024.12.04"', TRUE)
WHERE runner->>'name' = 'dosbox-x';

UPDATE games.releases
SET runner = jsonb_set(runner :: JSONB, '{ver}', '"0.74-3"', TRUE)
WHERE runner->>'name' = 'dosbox';

UPDATE games.releases
SET runner = jsonb_set(runner :: JSONB, '{ver}', '"2.9.0"', TRUE)
WHERE runner->>'name' = 'scummvm';

UPDATE games.releases
SET runner = jsonb_set(runner :: JSONB, '{ver}', '"0.82.0"', TRUE)
WHERE runner->>'name' = 'dosbox-staging';

UPDATE games.releases
SET app_reqs = jsonb_set(app_reqs :: JSONB, '{ua,lock_pointer}', 'true', TRUE)
WHERE name = 'Voyeur II';

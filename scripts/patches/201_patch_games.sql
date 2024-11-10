\c yag;

-- IGDB doesn't support custom ESRB ratings on their end, so patching them here
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' = 'styrlitz';
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' = 'red-comrades-save-the-galaxy';

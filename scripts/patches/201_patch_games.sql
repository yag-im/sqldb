\c yag;

-- IGDB doesn't support custom ESRB ratings on their end, so patching them here
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' = 'styrlitz';
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' = 'red-comrades-save-the-galaxy';
UPDATE games.games set short_descr = 'A full-motion video, point-and-click action-adventure game rated (AO) Adults Only. Hint: use Ctrl+F4 to swap CDs during the game.' WHERE igdb ->> 'slug' = 'riana-rouge';

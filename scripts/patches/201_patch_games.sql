\c yag;

-- IGDB doesn't support custom ESRB ratings on their end, so patching them here
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' IN (
    'styrlitz',
    'red-comrades-save-the-galaxy'
);

-- DMCA https://lumendatabase.org/notices/47379973?utm_medium=panel
UPDATE games.releases set is_visible = false where name IN (
    'Myst'
);

-- custom descriptions
UPDATE games.games set short_descr = 'A full-motion video, point-and-click action-adventure game rated (AO) Adults Only. Hint: use Ctrl+F4 to swap CDs during the game.' WHERE igdb ->> 'slug' = 'riana-rouge';
UPDATE games.games set short_descr = short_descr || ' HINT: Search for "Stealth Affair Color Protection" to bypass the protection screen.' WHERE igdb ->> 'slug' = 'james-bond-007-the-stealth-affair';

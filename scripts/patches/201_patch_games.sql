\c yag;

-- IGDB doesn't support custom ESRB ratings on their end, so patching them here
UPDATE games.games set esrb_rating = 11 WHERE igdb->>'slug' IN (
    'styrlitz',
    'red-comrades-save-the-galaxy',
    'geisha',
    'fascination',
    'plumbers-don-t-wear-ties',
    'red-comrades-for-the-great-justice',
    'leisure-suit-larry-in-the-land-of-the-lounge-lizards',
    'leather-goddesses-of-phobos-2-gas-pump-girls-meet-the-pulsating-inconvenience-from-planet-x',
    'personal-nightmare',
    '7-dni-a-7-noci',
    'phantasmagoria-2-a-puzzle-of-flesh',
    'nuclear-titbit'
);

-- DMCA https://lumendatabase.org/notices/47379973?utm_medium=panel
UPDATE games.releases set is_visible = false where name IN (
    'Myst'
);

-- custom descriptions
UPDATE games.games set short_descr = 'A full-motion video, point-and-click action-adventure game rated (AO) Adults Only. Hint: use Ctrl+F4 to swap CDs during the game.' WHERE igdb ->> 'slug' = 'riana-rouge';
UPDATE games.games set short_descr = short_descr || ' HINT: Search for "Stealth Affair Color Protection" to bypass the protection screen.' WHERE igdb ->> 'slug' = 'james-bond-007-the-stealth-affair';

DELETE FROM games.releases where name = 'King''s Quest';

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
    'nuclear-titbit',
    'spellcasting-101-sorcerers-get-all-the-girls'
);

UPDATE games.games set esrb_rating = 10 WHERE igdb->>'slug' IN (
    'quest-for-glory-ii-trial-by-fire'
);

-- DMCA https://lumendatabase.org/notices/47379973?utm_medium=panel
UPDATE games.releases set is_visible = false where name IN (
    'Myst'
);

-- custom descriptions
UPDATE games.games set short_descr = 'A full-motion video, point-and-click action-adventure game rated (AO) Adults Only. Hint: use Ctrl+F4 to swap CDs during the game.' WHERE igdb ->> 'slug' = 'riana-rouge';
UPDATE games.games set short_descr = short_descr || ' HINT: Search for "Stealth Affair Color Protection" to bypass the protection screen.' WHERE igdb ->> 'slug' = 'james-bond-007-the-stealth-affair';

DELETE FROM games.releases where name = 'King''s Quest';

-- update an EDUCATIONAL genre
-- get new candidates:
/*
select gr.id, game_id, gr.name, gg.genres, gg.igdb->'slug'
from games.releases gr
         join games.games gg ON (gg.id) = gr.game_id
WHERE NOT (1000000 = ANY(gg.genres))
order by id desc;
*/

UPDATE games.games
SET genres = genres || 1000000
WHERE igdb ->> 'slug' IN (
    'jumpstart-adventures-5th-grade-jo-hammet-kid-detective',
    'jumpstart-reading-for-second-graders',
    'the-cluefinders-3rd-grade-adventures-the-mystery-of-mathra',
    'the-cluefinders-4th-grade-adventures-puzzle-of-the-pyramid',
    'jumpstart-typing',
    'rayman-activity-center',
    'reader-rabbit-kindergarten--2',
    'jumpstart-math-for-second-graders',
    'jumpstart-1st-grade-math',
    'tonka-search-and-rescue-2',
    'tonka-search-and-rescue',
    'tonka-workshop',
    'iz-and-auggie-escape-from-dimension-q',
    'elroy-hits-the-pavement',
    'pantsylvania',
    'magic-wardrobe',
    'my-disney-kitchen',
    'how-many-bugs-in-a-box--1',
    'the-land-before-time-activity-center',
    'arthurs-camping-adventure',
    'arthurs-thinking-games',
    'arthurs-reading-games',
    'candy-land-adventure--1',
    'disneys-timon-and-pumbaas-jungle-games',
    'mr-potato-head-activity-pack',
    'disneys-story-studio-disneys-mulan',
    'disneys-animated-storybook-the-hunchback-of-notre-dame',
    'disneys-beauty-and-the-beast-magical-ballroom',
    'barney-on-location-all-around-town',
    'barbie-super-sports',
    'barbie-magic-hair-styler',
    'barbie-fashion-designer',
    'search-for-the-secret-keys',
    'little-monster-private-eye-the-mummy-mystery',
    'mercer-mayers-little-critter-and-the-great-race',
    'jumpstart-preschool--1',
    'mr-potato-head-saves-veggie-valley',
    'play-doh-creations',
    'adventures-with-barbie-ocean-discovery',
    'richard-scarrys-busytown--1',
    'the-fennels-figure-math',
    'dr-seuss-kindergarten',
    'fisher-price-time-to-play-pet-shop',
    'jumpstart-2nd-grade',
    'jumpstart-adventures-3rd-grade-mystery-mountain',
    'magic-tales-baba-yaga-and-the-magic-geese',
    'cosmic-family',
    'carmen-sandiegos-great-chase-through-time',
    'get-ready-for-school-charlie-brown',
    'barbie-adventure-riding-club',
    'detective-barbie-2-the-vacation-mystery',
    'detective-barbie-in-the-mystery-of-the-carnival-caper',
    'madeline-european-adventures',
    'jumpstart-adventures-4th-grade-haunted-island',
    'pong-pongs-learning-adventure-mysteries-of-human-body',
    'elroy-goes-bugzerk',
    'richard-scarrys-busytown-best-math-ever',
    '3-d-dinosaur-adventure',
    'math-for-the-real-world',
    'qin-tomb-of-the-middle-kingdom',
    'karma-curse-of-the-12-caves',
    'aliens-a-comic-book-adventure',
    'the-great-math-adventure',
    'the-great-word-adventure',
    'the-universe-according-to-virgil-reality',
    'disneys-animated-storybook-toy-story',
    'disneys-adventures-in-typing-with-timon-and-pumbaa',
    'disney-learning-math-quest-with-aladdin',
    'lets-explore-the-jungle',
    'lets-explore-the-airport',
    'lets-explore-the-farm',
    'schoolhouse-rock-america-rock',
    'schoolhouse-rock-math-rock'
);

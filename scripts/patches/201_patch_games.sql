\c yag;

-- missing genre
-- get new candidates:
/*
SELECT r.id, r.uuid, r.name, g.genres, g.igdb->>'slug' as igdb_slug
FROM games.releases r
    JOIN games.games g on r.game_id = g.id
WHERE esrb_rating is null AND NOT (1000000 = ANY(g.genres))
LIMIT 500;
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
    'schoolhouse-rock-math-rock',
    'adiboo-magical-playland',
    'amazon-trail-3rd-edition-rainforest-adventures',
    'animated-storybook-winnie-the-pooh-and-the-honey-tree',
    'big-thinkers-1st-grade',
    'bill-nye-the-science-guy-stop-the-rock',
    'blinky-bills-ghost-cave',
    'capn-crunchs-crunchling-adventure',
    'casper-brainy-book',
    'castle-explorer--1',
    'curious-george-early-learning-adventure',
    'darby-the-dragon',
    'easy-bake-kitchen',
    'ecoquest-ii-lost-secret-of-the-rainforest',
    'fisher-price-big-action-garage',
    'fisher-price-learning-in-toyland',
    'freddi-fish-and-luthers-water-worries',
    'gadget-invention-travel-and-adventure',
    'great-adventures-by-fisher-price-wild-western-town',
    'great-adventures-castle',
    'gregory-and-the-hot-air-balloon',
    'har-kommer-pippi-langstrump',
    'jumpstart-kindergarten--1',
    'jumpstart-toddlers',
    'living-books-aesops-the-tortoise-and-the-hare',
    'living-books-arthurs-birthday',
    'living-books-arthurs-computer-adventure',
    'living-books-arthurs-reading-race',
    'living-books-arthurs-teacher-trouble',
    'living-books-dr-seusss-abc',
    'living-books-green-eggs-and-ham',
    'living-books-just-grandma-and-me--1',
    'living-books-little-monster-at-school--1',
    'living-books-ruffs-bone',
    'living-books-sheila-rae-the-brave',
    'living-books-stellaluna',
    'living-books-the-berenstain-bears-get-in-a-fight',
    'living-books-the-berenstain-bears-in-the-dark',
    'living-books-the-cat-in-the-hat',
    'living-books-the-new-kid-on-the-block',
    'magic-school-bus-volcano-adventure',
    'math-rabbit-deluxe',
    'mega-math-blaster',
    'mickeys-space-adventure',
    'my-favorite-monster',
    'once-upon-a-time-abracadabra',
    'once-upon-a-time-baba-yaga',
    'orlys-draw-a-story',
    'pajama-sams-games-to-play-on-any-day',
    'pajama-sams-lost-and-found',
    'peppers-adventures-in-time',
    'pettson-o-findus-i-snickarbon',
    'pettson-o-findus-i-tradgarden',
    'pettson-o-findus-och-mucklornas-varld',
    'rayman-brain-games',
    'reader-rabbit-1st-grade',
    'reader-rabbit-3',
    'reading-blaster-2000',
    'reading-blaster-ages-9-12',
    'rocketts-new-school',
    'skipper-and-skeeto-mollys-musikmaskine',
    'skipper-and-skeeto-tales-from-paradise-park',
    'skipper-and-skeeto-the-great-treasure-hunt',
    'snowball--1',
    'storybook-weaver-deluxe',
    'the-jungle-book',
    'the-magic-school-bus-explores-bugs',
    'the-magic-school-bus-explores-in-the-age-of-dinosaurs',
    'the-magic-school-bus-explores-the-ocean',
    'the-magic-school-bus-explores-the-world-of-animals',
    'thomas-and-friends-the-great-festival-adventure',
    'thomas-and-friends-trouble-on-the-tracks',
    'tiffys-magical-tales-pinocchio',
    'welcome-to-bodyland',
    'where-in-the-world-is-carmen-sandiego-treasures-of-knowledge',
    'a-dot-j-s-world-of-discovery',
    'alice-an-interactive-museum',
    'blues-art-time-activities',
    'bygg-bilar-med-mulle-meck',
    'bygg-hus-med-mulle-meck',
    'cosmic-relief-prof-renegade-to-the-rescue',
    'freddi-fishs-one-stop-fun-shop',
    'josephine-and-friends',
    'josephine-at-school',
    'josephine-on-holiday',
    'jumpstart-1st-grade-reading',
    'jumpstart-kindergarten-reading',
    'jumpstart-phonics',
    'pajama-sams-one-stop-fun-shop',
    'pajama-sams-sock-works',
    'search-for-the-golden-dolphin',
    'sesame-street-the-three-grouchketeers',
    'super-solvers-treasure-mountain',
    'thinkin-things-collection-2',
    'treasure-cove--1',
    'treasure-mathstorm',
    'zoombinis-logical-journey',
    'jumpstart-spanish',
    'treasures-of-the-smithsonian'
) AND NOT (1000000 = ANY(COALESCE(genres, '{}')));

-- remove copyrighted titles
-- DMCA https://lumendatabase.org/notices/47379973?utm_medium=panel
UPDATE games.releases set is_visible = false where name IN (
    'Myst'
    );

UPDATE games.releases SET is_visible = false
WHERE name ilike '%barbie%' OR
    name ilike '%disney%' OR
    name ilike '%mickey%' OR
    name ilike '%mario%' OR
    name ilike '%rugrats%';

UPDATE games.releases r
SET is_visible = false
WHERE EXISTS (
    SELECT 1
    FROM jsonb_array_elements(r.companies) AS comp(elem)
    WHERE (comp.elem->>'publisher')::boolean = true
      AND (comp.elem->>'id')::int IN (
        SELECT id
        FROM games.companies
        WHERE name ILIKE '%disney%'
           OR name ILIKE '%mattel%'
           OR name ILIKE '%lucas%'
           OR name ILIKE '%hasbro%'
    )
);

-- custom descriptions
UPDATE games.games set short_descr = 'A full-motion video, point-and-click action-adventure game rated (AO) Adults Only. Hint: use Ctrl+F4 to swap CDs during the game.' WHERE igdb ->> 'slug' = 'riana-rouge';
UPDATE games.games set short_descr = short_descr || ' HINT: Search for "Stealth Affair Color Protection" to bypass the protection screen.' WHERE igdb ->> 'slug' = 'james-bond-007-the-stealth-affair';

DELETE FROM games.releases where name = 'King''s Quest';

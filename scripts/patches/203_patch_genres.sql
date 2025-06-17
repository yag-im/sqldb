\c yag;

INSERT INTO games.genres(id, name) VALUES (1000000, 'Educational');

UPDATE games.games SET genres = '{1000000}' WHERE id in (
    1000000,
    1000002,
    1000003,
    1000015
)

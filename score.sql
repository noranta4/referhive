CREATE VIEW IF NOT EXISTS white_scores AS
SELECT
    timestamp,
    white AS player,
    CASE
        WHEN outcome = 'WhiteWins' THEN 3
        WHEN outcome = 'BlackWins' THEN 0
        WHEN outcome = 'Draw' THEN 1
    END AS score
FROM games;

CREATE VIEW IF NOT EXISTS black_scores AS
SELECT
    timestamp,
    black AS player,
    CASE
        WHEN outcome = 'WhiteWins' THEN 0
        WHEN outcome = 'BlackWins' THEN 3
        WHEN outcome = 'Draw' THEN 1
    END AS score
FROM games;


.print ====================== Leaderboard ===========================
SELECT player, sum(score) AS total_score
FROM (
    SELECT * FROM white_scores
    UNION ALL
    SELECT * FROM black_scores)
GROUP BY player
ORDER BY total_score DESC;

.print
.print ====================== Matches detail =========================
SELECT white, black, outcome FROM games;


.print
.print How many times are outcomes occurring?
SELECT outcome, count(*) FROM games GROUP BY outcome;

.print
.print Game length stats
SELECT avg(elapsed_s) as avg_time, max(elapsed_s) as max_time, min(elapsed_s) as min_time
FROM games;

.print Shortest game
SELECT white, black, outcome, elapsed_s
FROM games
GROUP BY ''
HAVING elapsed_s = min(elapsed_s);

.print Longest game
SELECT white, black, outcome, elapsed_s
FROM games
GROUP BY ''
HAVING elapsed_s = max(elapsed_s);

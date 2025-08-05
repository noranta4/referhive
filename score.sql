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

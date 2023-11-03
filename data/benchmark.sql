PRAGMA foreign_keys = 0;
DROP TABLE tSample;
CREATE TABLE tSample (
      chat_id NOT NULL
    , run_time REAL (64) NOT NULL DEFAULT ((datetime('now', 'localtime')))
    , bmk_prompt TEXT NOT NULL
    , bmk_completion TEXT NOT NULL
    , cos_sim NUMERIC NOT NULL
    , api_completion TEXT );
PRAGMA foreign_keys = 1;

INSERT INTO tSample (
      chat_id 
    , run_time
    , bmk_prompt
    , bmk_completion
    , cos_sim 
    , api_completion)
    VALUES (
      ?
    , ?
    , ?
    , ?
    , ?
    );
    
SELECT * FROM tSample;

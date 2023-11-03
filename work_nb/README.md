# Generative AI - Issue & Observability

This directory contains the working notebooks that have  all the necessary code to get you from A-Z. These are also the files from which the article code snippets were taken.

### First:
After you set up Python and VSCODE (as needed), set up 
  1. Weaviate
  2. Cohere account
  3. Nomic Atlas account
  4. SQLite

Then confirm external resources are working:
Run the scripts in [data\confirm_external_resources.ipynb](data\confirm_external_resources.ipynb)


### Data Origin
Data was harvested, cleaned and formatted from 
https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered
License: apache-2.0

See: [work_nb\01_clean_data.ipynb](work_nb\01_clean_data.ipynb)

### About the data in: data\\*

Please see the [LICENSE](LICENSE) file (Apache 2.0)

*data\\* is the location of the sqlite database: ***driftDb.db***

You need clean data when you send it to the Gen AI API or import into your vector database. There are two data directories:
1. [data\clean\](data\clean\)
2. [data\raw\](data\raw\)


### Data: raw or cleaned & formatted
***data/clean directory***

There are three files with cleaned data, suitable fo use during development.
The number in the file name is the number of json objects (chat pairs) in each file.

#### Raw data files
1. [data\raw\ShareGptChatPairs_3330.json](data\raw\ShareGptChatPairs_3330.json)
2. [data\raw\ShareGptChatPairs_dev_10.json](data\raw\ShareGptChatPairs_dev_10.json)
3. [data\raw\ShareGptChatPairs_dev_32.json](data\raw\ShareGptChatPairs_dev_32.json)


#### Cleaned & formatted data files
1. [data\clean\ShareGptChatPairs_2_clean_fmt.json](data\clean\ShareGptChatPairs_2_clean_fmt.json)
2. [data\clean\ShareGptChatPairs_dev_10_cleaned.json](data\clean\ShareGptChatPairs_dev_10_cleaned.json)
3. [data\clean\ShareGptChatPairs_2415_cleaned.json](data\clean\ShareGptChatPairs_2415_cleaned.json)


## Notebooks

Once weaviate, cohere, sqlite and nomic are working, the work notebooks will take you from raw data to your first set of benchmark sample data.

The files are numbered in order of execution

*Start small*

If you're using a free completion API account, it's probably wise to not use up all your credits.

Work with the small raw & cleaned datasets until you're sure you want to spend money on a paid account. 
For example: *data\clean\ShareGptChatPairs_dev_10_cleaned.json*

## Steps:

0. [Delete out the old data in weaviate and sqlite](work_nb\00_clean_weaviate_and_sqlite.ipynb)
1. [Clean and format the raw data](work_nb\01_clean_data.ipynb)
2. [Import clean data to weaviate](work_nb\02_drift_benchmark_import.ipynb)
3. [Run the benchmark queries](work_nb\03_drift_benchmark_queries.ipynb)
4. [Visualize and explore the benchmark data in a browser](work_nb\04_drift_nomic.ipynb)

Each of the notebooks contains markdown explaining what is going on.

### Explanation for #3. Run the benchmark queries 

### Weaviate connection error
error getting credentials - err: exec: "docker-credential-desktop": executable file not found in %PATH%, out: ``

Edit {user}\.docker\config.json

```json
{
  "credsStore": "desktop" <- DELETE THIS LINE
}
```





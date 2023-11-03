# Generative AI - Issue & Observability 

### Confirm external resources are working:
Run the scripts in [data\confirm_external_resources.ipynb](data\confirm_external_resources.ipynb)


### Notebooks in *dev_nb* directory
There are 2 types of files in the dev_nb directory:
1. Files for monkeying around with whichever tech is in the file name: ***_{name}*_exp.ipynb***
2. The dev notebook files end are name similarly: ***01_{name}*_dev.ipynb***
These are files I wrote while developing this project. Like the files in the *work_nb* directory, they are numbered in order of the process steps: 0 thru x. Some of it is the same code found in the files in the *work_nb* directory files.


### Data in data directory
Please see the [Apache 2.0](LICENSE) license file located in the *data* directory.

data\ is the location of the sqlite database: driftDb.db

You need clean data when you send it to the gen ai API or import into your vector database.
There are two data directories:
1. [data\clean\](data\clean\)
2. [data\raw\](data\raw\)

### Data Origin
Data was harvested, cleaned and formatted from 
https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered
License: apache-2.0

See: [work_nb\01_clean_data.ipynb](work_nb\01_clean_data.ipynb)


### Data: raw or cleaned & formatted
There are three files with cleaned data, suitable fo use during development
The number in the file name is the number of json objects (chat pairs) in each file.

#### Raw data files
1. [data\raw\ShareGptChatPairs_3330.json](data\raw\ShareGptChatPairs_3330.json)
2. [data\raw\ShareGptChatPairs_dev_10.json](data\raw\ShareGptChatPairs_dev_10.json)
3. [data\raw\ShareGptChatPairs_dev_32.json](data\raw\ShareGptChatPairs_dev_32.json)


#### Cleaned & formatted data files
1. [data\clean\ShareGptChatPairs_2_clean_fmt.json](data\clean\ShareGptChatPairs_2_clean_fmt.json)
2. [data\clean\ShareGptChatPairs_dev_10_cleaned.json](data\clean\ShareGptChatPairs_dev_10_cleaned.json)
3. [data\clean\ShareGptChatPairs_2415_cleaned.json](data\clean\ShareGptChatPairs_2415_cleaned.json)

Cleaning data is covered in [\dev\clean_data.ipynb](\dev\clean_data.ipynb)




### Confirm external resources are working:
Run the scripts in [data\confirm_external_resources.ipynb](data\confirm_external_resources.ipynb)


## DEV NOTEBOOKS
***The notebook files are numbered by order; start with 0***


### Cleaning raw data with spaCy
https://spacy.io/ 
https://spacy.io/api/top-level 

Start by trying out the scripts in [dev_nb\spacy_sentence_to_tokens_dev.ipynb](dev_nb\spacy_sentence_to_tokens_dev.ipynb).
This will show you how spaCy can be used to:
* tokenize text, 
* get an array of sentences from text, 
* perform language detection

All of the above are used in the drift benchmark code to clean the chat prompts and completions data in the \data\raw directory.

***N.B.*** Note the use of spacy.prefer_gpu()
Will it make a difference in processing time?


Once you're ready, you can get to work and clean and format the data!
[work_nb\clean_data.ipynb](work_nb\clean_data.ipynb)


### Working with SQLite:
[dev_nb\02_sqlite_db_dev.ipynb](dev_nb\02_sqlite_db_dev.ipynb)

Includes:
* List tables
* DROP all tables
* SQLite Basics
* A handy query to tell you which database file you are using.


### Working with Weaviate:
[dev_nb\03_weaviate_queries_dev.ipynb](dev_nb\03_weaviate_queries_dev.ipynb)

Includes:
* Delete classes with WHERE filter
* Filter where property value is less than
* Count with filter where property value is less than
* Get query
* The there are queries that include using sentence-transformers.
* Finally, an interactive query using semantic similarity, which in Weaviate is called 'certainty'



#### Weaviate connection error
>error getting credentials - err: exec: "docker-credential-desktop": executable file not found in %PATH%, out: ``

Solution: edit the {user}\.docker\config.json file and delete the line indicated below:
```json
{
  "credsStore": "desktop" <- DELETE THIS LINE
}
```


### Putting It All Together:
[dev_nb\04_drift_benchmark_queries_dev.ipynb](dev_nb\04_drift_benchmark_queries_dev.ipynb)

This file uses all of the above to perform each of the steps required to build the drift benchmark.
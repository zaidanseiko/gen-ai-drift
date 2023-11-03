# Generative AI - Issue & Observability 
Developing an observability solution for Generative AI semantic content drift.

First, a word of explanation about the collection of notebooks in this project. My goal was to make it as easy as possible for you to adapt my use case to your use case - whatever it may be.

Like you, I make great use of tutorials and open source code. And, like you, my use case is never quite the same as the use cases in the tutorials or open source code. Again, like you, I spend a lot of time understanding the code and adapting it to my use case. The notebooks in this project are the pieces of work I have done while adapting various bits of source code to the article's use case: ***building a way to monitor semantic content drift of a vendor-supplied generative AI system.*** 

To get from nothing to a prototype, there are a number of text processing steps, and each of those steps has a separate notebook or part of a notebook. This should make it much easier for you to adapt this code to your use case.

The steps involved in getting from A to Z are:

1. Which Gen AI API will you be using?
1. What kind of data (prompts and completions) will your use case require in order to create the benchmark sample dataset?
1. If you don't have it already available, find something close enough in a public dataset like huggingface.co
1. When you have it, clean and format it.
1. Once your data set it cleaned and formatted, experiment with sentence embeddings and a few similarity functions.
1. Once you have chose a embedding and similarity solution, maybe re-clean and re-format your data.
1. Pick a Vector database (VBD) that works for your use case.
1. Write the code to encode the embedding vectors and save to your VDB.
1. Write the code to foreach the benchmark samples and send the prompts to the Gen AI API
1. Calculate the embeddings for completions returned
1. [Optional] Save the response completions and embedding in a VDB
1. Calculate the similarity and save that to a db, relational probably, cause it's time series: one prompt will have many completions.
1. Run this process every day or week
1. Generate and distribute some kind of report on the results.

***Bonus***: Once you've done semantic content drift, if you need it you can do factual accuracy drift/error and sentiment drift of your user's prompts. 

Let me know if I have achieved my goal of making it easier for you to adapt this code to your use case.

And, as always, ***have fun storming the castle!***

~P

## !Absolutely read this:
The data provided in this project has one goal in mind: make development easy.

The data in the raw and cleaned directories came from actual chats used when training the open source chatbot called Vicuna. 

When you run the code in these notebooks using the cohere.ai completion API, you will receive very different completions from the completions in the raw data. This was done so that you (and I) don't write a bug because we get the benchmark sample completion mixed up with the daily/weekly completion from the actual API.

Consider this: You write a a bunch of lovely prompts and send them to your favorite Gen AI completion API.
You write this to JSON and use these prompts and completions as your dev data. It would be very easy to mix up *request["completion"]* with *response["completion"]* if the benchmark completion text in the vector db is identical to the API response completion text.

Or, because both texts are identical, you mistakenly think you have a defect in code.

That won't happen with the data I have provided because the benchmark completion text in the vector db is going to be very different from the API response completion text.

Cheers!


## Contents Overview

***N.B.*** There are README files in the *dev_nb* and *work_nb* directories.  
  

### Organization
1. What's in the project?
2. Development data
3. Installation of everything (assuming you have nothing).
4. API Key Security(.env) 
5. Vector DB Setup (Weaviate & Nomic atlas visualization)
6. Cohere Generative AI Account Setup
7. SQLite Setup
  


## 1. What's in the project?

### Jupyter Notebooks
* All code is contained within *.ipynb script files.
* These notebooks are organized into dev and work directories.
* VSCode was used to develop this project. 
* VSCODE extensions are listed below.

### Notebooks in *dev_nb*
All of the dev notebook files end with _dev.ipynb  

These are files I wrote while developing this project. 
You may them useful for learning and experimentation. 

### Notebooks in *work_nb*
These are the working notebooks that contain the all necessary code to get you from zer0 to drift benchmarks. They are organized so that each step builds on the previous, and makes it easier for you to extract and adapt the code to your use case.

These are also the files from which the article code snippets were taken.


### Data Origin
Data was harvested, cleaned and formatted from 
https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered
License: apache-2.0

See: [work_nb\01_clean_data.ipynb](work_nb\01_clean_data.ipynb)

### Development Data in *data*
You'll need clean data when you send it to the gen ai API or import into your vector database. 
All data is located in *data* directorY



## 2. Development Data
Data is licensed under [Apache 2.0](LICENSE). The license file is located in the *data* directory.

Data has been provided in a raw form and cleaned and formatted, ready for to use:

1. [data\clean\](data\clean\)
2. [data\raw\](data\raw\)

There are three files with cleaned data, suitable for use during development. The number in the file name is the number of json objects (chat pairs) in each file.


#### Raw data files
1. [data\raw\ShareGptChatPairs_3330.json](data\raw\ShareGptChatPairs_3330.json)
2. [data\raw\ShareGptChatPairs_dev_10.json](data\raw\ShareGptChatPairs_dev_10.json)
3. [data\raw\ShareGptChatPairs_dev_32.json](data\raw\ShareGptChatPairs_dev_32.json)


#### Cleaned & formatted data files
1. [data\clean\ShareGptChatPairs_2_clean_fmt.json](data\clean\ShareGptChatPairs_2_clean_fmt.json)
2. [data\clean\ShareGptChatPairs_dev_10_cleaned.json](data\clean\ShareGptChatPairs_dev_10_cleaned.json)
3. [data\clean\ShareGptChatPairs_2415_cleaned.json](data\clean\ShareGptChatPairs_2415_cleaned.json)

Cleaning data is covered in [\dev\clean_data.ipynb](\dev\clean_data.ipynb)


## 3. Install Everything
Assuming you have absolutely nothing

### VSCODE IDE
https://code.visualstudio.com/download 

Getting started with Jupyter in VSCOde
https://donjayamanne.github.io/pythonVSCodeDocs/docs/jupyter_getting-started/

Ctrl+Shit+P - Python
for handy python commands in vscode

#### VSCODE Extensions
These are the extensions I installed:

```
code --install-extension donjayamanne.python-environment-manager
code --install-extension donjayamanne.python-extension-pack
code --install-extension {YOUR_ACCT}Rose.vsc-python-indent
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
```

### Python
I prefer the lightweight miniconda installation:
https://docs.conda.io/en/latest/miniconda.html 


#### Install Project's Python Requirements
***requirements.txt*** contains the version of packages required to run the notebooks. From a CMD/PS/BASH prompt execute:
```
pip install -r requirements.txt
```


## 4. API Key Security!
FOr use in the notebooks, the API keys must be stored in the *.env* file. There is an *env* file containing variables without values. Rename it to .env (dot env) and add you API keys.  

Note that the entries in the .env file do not use whitespace or quotes:
```
NOMIC_API_KEY=xjTljhsdfjhIuhBIIJBASDx_
COHERE_API_KEY=uhBIIJabcasd1234kjASFkjfjhIBASDx_
```

The .gitignore file contins this an ignore entry for your dot env file:
```
# api keys
.env
```

No need to use real environment variables. The API Keys are loaded using *load_dotenv*: 
```python
import os
from dotenv import load_dotenv
load_dotenv()
api_key = os.getenv('NOMIC_API_KEY')
```

Get your api keys from the URLs in # 5, below

## 5. Vector Database Setup
The Vector database space is moving insanely fast. I've found that most of the startups don't have time or resources to keep their docs or tutorials up to date.

I chose Weaviate because it's a very easy-to-work-with vector db. I tried several of the usual suspects but found that Weaviate tutorials worked first time and the documentation is complete enough.

The feature I like the most is the ability to create a schema with any properties or fields that are needed, and choose which fields will be vectorized.

Weaviate was also easy to use via docker. There's also a free to try cloud version.  

#### Weaviate on docker
You can generate a new docker-compose.yml or use the one provided in this project.

Make sure you have docker engine and docker-compose installed and in your PATH.
https://www.docker.com/products/docker-desktop/ 

Weaviate has a docker-compose configuration tool on their site: 
https://weaviate.io/developers/weaviate/installation/docker-compose

I have included my [docker-compose.yml](docker-compose.yml) 

After you run the Weaviate contaier, check it's working with http://localhost:8080/

### Weaviate connection error
If you get this error
>error getting credentials - err: exec: "docker-credential-desktop": executable file not found in %PATH%, out: ``

Edit the {user}\.docker\config.json and remove the line as shown:

```json
{
  "credsStore": "desktop" <- DELETE THIS LINE
}
```

### Sentence Transformers
Sentence transformers are the OG. History and explanation available here:
https://towardsdatascience.com/attention-is-all-you-need-discovering-the-transformer-paper-73e5ff5e0634

More information about them can be found here: https://www.sbert.net/ and here: https://huggingface.co/sentence-transformers 

If you would like to try a different sentence transformer, look here: https://www.sbert.net/docs/pretrained_models.html

#### This project uses 'multi-qa-MiniLM-L6-cos-v1'
The sentence transformer chosen for this project is documented here
[sentence-transformers/multi-qa-MiniLM-L6-cos-v1](https://huggingface.co/sentence-transformers/multi-qa-MiniLM-L6-cos-v1) 

It maps sentences & paragraphs to a 384 dimensional dense vector space and was designed for semantic search. It has been trained on 215M (question, answer) pairs from diverse sources. For an introduction to semantic search, have a look at: SBERT.net - Semantic Search

| Description:              | This model was tuned for semantic search: Given a query/question, if can find relevant passages. It was trained on a large and diverse set of (question, answer) pairs. |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Base Model:               | nreimers/MiniLM-L6-H384-uncased                                                                                                                                         |
| Max Sequence Length:      | 512                                                                                                                                                                     |
| Dimensions:               | 384                                                                                                                                                                     |
| Normalized Embeddings:    | true                                                                                                                                                                    |
| Suitable Score Functions: | dot-product (util.dot_score), cosine-similarity (util.cos_sim), euclidean distance                                                                                      |
| Size:                     | 80 MB                                                                                                                                                                   |
| Pooling:                  | Mean Pooling                                                                                                                                                            |
| Training Data:            | 215M (question, answer) pairs from diverse sources.



### Vector DB Visual Exploration
Visualizing your sentence embedding vectors is powerful way of exploring your data. It's particularly helpful when you are creating a benchamrk sample set of promts for your use case.

This project uses free resources available from https://atlas.nomic.ai/

Click button labeled: Get Started with Atlas


### How to visualize weaviate data:
https://docs.nomic.ai/vector_database.html#weaviate

If you're not seeing the correct data in nomic atlas, 
go to https://atlas.nomic.ai/dashboard 
and check the list of projects and make sure you're looking at the right one.
You umay want to delete the existing indexes for a project.
I advise against deleting an entire project. That caused me some trouble...

implemented here: 
 1. [dev_nb\nomic.ipynb](dev_nb\nomic_start_here_dev.ipynb)
 1. [work_nb\drift_nomic.ipynb](work_nb\drift_nomic.ipynb)


## 6. Generative AI Account Setup
This project used a free API account at cohere.ai

Cohere API Trial key is limited to 5 API calls/minute. 
You can continue to use the Trial key for free or upgrade to a Production key with higher rate limits at 'https://dashboard.cohere.ai/api-keys'. 


Open https://cohere.com/ 
Click on Try Now button upper right corner.

### The Cohere Platform
https://docs.cohere.com/docs


## 7. SQLite
SQLite is used to store the time-series data generated when we run the benchmark sample every day or week or...

Setup is incredibly simple:
https://www.sqlite.org/index.html

Sqlite Tools:
A bundle of command-line tools for managing SQLite database files, including the command-line shell program, the sqldiff.exe program, and the sqlite3_analyzer.exe program.

and a GUI: https://sqlitestudio.pl/ 

### Create a project db
A SQLite3 DB (data\driftDb.db) is included. 

and the sql DDL/DML: data\benchmark.sql

However, if you want to create your own: 
https://www.sqlite.org/quickstart.html



## Confirm external resources are working:
Run the scripts in [confirm_external_resources.ipynb](confirm_external_resources.ipynb)


## Now that setup is complete:
    1. Learn and experiment by using the notebooks in the dev/ directory, or
    2. Get straight to work with the notebooks in the work/ directory.


  ***Have fun storming the castle!***
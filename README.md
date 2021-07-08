# City of Ottawa's Tennis Courts - COBOL Project

COBOL is used to process data extracted from [Ottawa's Public Database](https://open.ottawa.ca/) about [Ottawa's public tennis courts](https://open.ottawa.ca/datasets/tennis-courts/explore?location=45.271816%2C-75.773591%2C1.88&showTable=true).

The project is divided in four major steps:
1. Extract data from Ottawa's database into `.csv` file:
   * `Curl` REST API request to extract data in JSON.
   * Linux `jq` command to query JSON into CSV format.
   * Linux `sed` command to replace special characters for their English equivalent letters before saving the results in a `.csv` file.
2. COBOL program to process `.csv` file into Line Sequential `.dat` with specific format for final display.
3. Second COBOL program to generate *Indexed* file from Line Sequential `.dat` file created in step 2.
4. Third COBOL program to read the indexed file:
   * Displays a menu for the user to choose one from many `key` options
   * Displays results in human readable format; computes and displays how many results were found
   * Displays a final menu for the user to choose to continue/start over or quit/exit.

### Details:

###### Data is taken from [Ottawa's Tennis Courts database](https://open.ottawa.ca/datasets/tennis-courts/explore?location=45.271816%2C-75.773591%2C1.88&showTable=true), through API request:  
[![Ottawa Database](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/otwdata.png?raw=true)](#)
<br/><br/>

###### `curl` command extracts the data:
[![Raw JSON](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/rawJson.png?raw=true)](#)
<br/><br/>

###### `jq` and `sed` commands process the results into `csv` format:
[![JSON to CSV](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/jsonToCsv.png?raw=true)](#)
<br/><br/>

###### COBOL program [processCbl.clb](cbl/processCsv.cbl) processes `.cvs` file into line sequential `.dat` file with standardized format:
[![CSV to DAT](https://user-images.githubusercontent.com/19538324/124975161-b6b48000-dffb-11eb-848a-a9f74d75ce95.png)](#)
<br/><br/>

###### After COBOL program [toIndex.cbl](cbl/toIndex.cbl) creates an indexed file from the `.dat` file generated in the step above, COBOL program [readIndex.cbl](cbl/readIndex.cbl) opens a user friendly menu to read the processed data:
[![Initial Menu](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/readIndex1.png?raw=true)](#)
<br/><br/>

###### The user can choose a selection and, depending on the option, will need to enter a value (e.g.: ID), select a value in a sub-menu (e.g: REGION), or the program automatically returns the positive values (e.g.: LIGHTS, BENCHES, etc.):
[![ID Selection](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/readIndex2.png?raw=true)](#)
<br/><br/>

###### After the result is displayed, the program prompts the user the option to quit/exit the program or to make another search:
[![REGION Selection](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/readIndex3.png?raw=true)](#)
<br/><br/>

###### The results also include the total of results displayed (in the footer):
[![CLUBHOUSE Selection](https://github.com/evertonvolpi/cobol-ottawas-tennis-courts/blob/main/img/readIndex4.png?raw=true)](#)
<br/><br/>

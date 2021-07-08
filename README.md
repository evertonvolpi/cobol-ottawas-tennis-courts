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

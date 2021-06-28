Files: 
#'num2words.R'
#'code_challenge.R'
#'shiny_app_num2words.R'
#'num2words_test_file.csv'
#'num2words_test_file.txt'

Comments:
#'num2words.R' is a function that converts a given number to words. 
#'code_challenge.R' is a script which cleans the Input data and then use the 'num2words' function to convert number into words.
#'shiny_app_num2words.R' is a shiny app where you can upload and input file (.CSV or .TXT) in order to generate the desired output. 
#Input data can be a .CSV or .TXT file.
#'num2words.R' and 'code_challenge.R' functions do not rely on any 3rd party library/package. Only 'shiny_app_num2words.R' uses a 3rd party library/package.
#2 test files have been provided 'num2words_test_file.csv' and 'num2words_test_file.txt'. These files contain the Test Input provided in the code challenges guidelines with addition of couple new examples. 

Assumptions:
#Numbers found in the sentences are below a quadrillion. Nevertheless, note that it is possible for the function to handle number >= quadrillion, you just need to add the relevant suffix in the 'suffixes' variable of the 'num2words' function (e.g. quintillion) 
#Input data only contain plain text
#No header in Input file. Note that the Shiny App can handle headers.

Instructions:
#Open the 'code_challenge' script and change the 'input_data_path' variable (line 4) with the relevant input file path ('num2words_test_file' can be used as input). Note that in order to read a .TXT file you need to use 'read.delim()' function instead of  'read.csv' function.
#Execute the script and the output will be displayed in the console. The output object has been named 'output_data' and can it can be display from the Global Environment (RStudio) 
#Note that the last section of the script 'Test with random numbers' enable you to test the function with random numbers between 1 and 1 trillion. To use this please just uncomment the 3 last rows of the script by removing the '#' character and then execute the 3 last rows

Technical Requirements: 
#R: ideally R version > 3.6.0
#In odrder to execute the shiny app, 'shiny' library is necessary. Ideally version > 1.6.0

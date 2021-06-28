#----------------------------------------------- Clean environement ------------------------------------
rm(list=ls(all=TRUE))
#----------------------------------------------- Require Shiny -----------------------------------------
require(shiny)
#----------------------------------------------- UI ----------------------------------------------------
ui <- fluidPage(titlePanel("num2words"),
    sidebarPanel(
      fileInput("file1", "Choose CSV/TXT File", accept = c(".csv",".txt")),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(
      tableOutput("input_output")
    )
  )
#----------------------------------------------- Server ------------------------------------------------
server <- function(input, output) {
  num2words <- function(x){
    ###############################
    ones <- c("", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine") 
    names(ones) <- 0:9
    teens <- c("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen","sixteen", " seventeen", "eighteen", "nineteen")
    names(teens) <- 0:9
    tens <- c("twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty","ninety") 
    names(tens) <- 2:9 
    suffixes <- c("thousand", "million", "billion", "trillion") #quadrillion etc...
    ###############################
    makeNumber <- function(...) as.numeric(paste(..., collapse=""))
    ##############################
    digits <- rev(strsplit(as.character(x), "")[[1]])
    nb_digits <- length(digits)
    
    if (nb_digits == 1) {
      words <- ones[digits][[1]]
    }else if (nb_digits == 2 & x <= 19 ) {                                                          
      words <- teens[digits][[1]]
    }else if (nb_digits == 2 & x >= 20 ) {
      words <- paste0(
        tens[digits][[2]],
        "-",
        ones[digits][[1]]
      )
    }else if (nb_digits == 3){
      words <-paste( 
        ones[digits][[3]],
        "hundred and",
        Recall(makeNumber(digits[2:1]))
      )
    } else {
      nb_suffix <- trunc(((nb_digits+2)/3)-1)
      if(nb_suffix > length(suffixes)) {
        words <- paste(x, "is too large!")
      }else {
        words <- paste(Recall(makeNumber(digits[
          nb_digits:(3*nb_suffix + 1)])),
          suffixes[nb_suffix],"," ,
          Recall(makeNumber(digits[(3*nb_suffix):1]))
        )
      }
    }
    return(words)
  }
  output$input_output <- renderTable({
    file <- input$file1
    ext <- tools::file_ext(file$datapath)
    req(file)
    validate(need(ext %in% c("csv","txt"), "Please upload a csv ot txt file"))
    
    if (ext == "csv") {
      input_data <- read.csv(file$datapath, header = input$header)
    }else if (ext == "txt"){
      input_data <- read.delim(file$datapath, header = input$header)
    }
    colnames(input_data) <- "input"
    #----------------------------------------------- Clean Input Data ------------------------------------------------------
    input_data$input_sentance_num_clean <- gsub("[[:alpha:]]", "", input_data$input) # remove alphabetical characters
    input_data$input_sentance_num_clean <- gsub("[.]", "", input_data$input_sentance_num_clean) # remove dots
    input_data$input_sentance_num_clean <- as.numeric(input_data$input_sentance_num_clean) # identify invalid number
    for (i in 1:nrow(input_data)){
    input_data$output[i] <-   num2words(input_data$input_sentance_num_clean[i])
    }
    input_data <- input_data[,c("input","output")]
    input_data$output[is.na(input_data$output)] <- "Invalid Number"
    input_data
  })
}
#----------------------------------------------- APP ---------------------------------------------------
shinyApp(ui, server)

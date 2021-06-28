num2words <- function(x){
  #------------------------------- Static Info -------------------------------------------
  ones <- c("", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine") 
  names(ones) <- 0:9
  teens <- c("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen","sixteen", " seventeen", "eighteen", "nineteen")
  names(teens) <- 0:9
  tens <- c("twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty","ninety") 
  names(tens) <- 2:9 
  suffixes <- c("thousand", "million", "billion", "trillion") #quadrillion etc...
  #------------------------------- Make Number function -----------------------------------
  makeNumber <- function(...) as.numeric(paste(..., collapse=""))
  #------------------------------- Find number of digits and digits -----------------------
  digits <- rev(strsplit(as.character(x), "")[[1]])
  nb_digits <- length(digits)
  #------------------------------- Create Word --------------------------------------------
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
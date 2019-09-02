best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ##selecting required variables
  fd   <- as.data.frame(cbind(data[, 2],   # hospital
                              data[, 7],   # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  ##change names of vaiables
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  ## %in% is value matching and "returns a vector of the positions of (first) 
  ##matches of its first argument in its second" (See help('%in%')) This means you 
  ##could compare vectors of different lengths to see if elements of one vector 
  ##match at least one element in another. 
  ##The length of output will be equal to the length of the vector being compared (the first one)
  if(!state %in% fd[, "state"]){
    stop('invalid state')
  } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else {
    ##selecting rows which contain the required state
    si <- which(fd[, "state"] == state)
    ##extracting data for the called state
    ts <- fd[si, ]
    ##eval()=get()
    ##get--> out put an object name(such as variable name) (
    ##given as a character string). 
    oi <- as.numeric(ts[, eval(outcome)])
    ##find the minium number 
    min_val <- min(oi, na.rm = TRUE)
    ##select the hosptial which satisfy the condition
    result  <- ts[, "hospital"][which(oi == min_val)]
    ##out put an order vector
    output  <- result[order(result)]
  }
  return(output)
}

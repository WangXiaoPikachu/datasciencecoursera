rankall <- function(outcome, num = "best"){
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  fd   <- as.data.frame(cbind(data[, 2],  # hospital
                              data[, 7],  # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  fd[, eval(outcome)] <- as.numeric(fd[, eval(outcome)])
  
  ## Check that state and outcome are valid
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if (is.numeric(num)) {
    #split the data set df into lists by state
    by_state <- with(fd, split(fd, state))
    ##change input into list 
    ordered  <- list()
    ##seq_alongseq_along 函数是for循环中可以注意的一个点。它的参数是一个vector，
    ##如x <- c('a', 'b')，
    ##调用seq_along(x)会得到一个序列，长度为2，值为1，2
    for (i in seq_along(by_state)){
      ###[[]]can select elements in the list
      by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                           by_state[[i]][, "hospital"]), ]
      ####creat a list 
      ordered[[i]]  <- c(by_state[[i]][num, "hospital"], by_state[[i]][, "state"][1])
    }
    #### rbind all ordered together 
    result <- do.call(rbind, ordered)
    output <- as.data.frame(result, row.names = result[, 2], stringsAsFactors = FALSE)
    names(output) <- c("hospital", "state")
  } else if (!is.numeric(num)) {
    if (num == "best") {
      by_state <- with(fd, split(fd, state))
      ordered  <- list()
      for (i in seq_along(by_state)){
        by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                             by_state[[i]][, "hospital"]), ]
        ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else if (num == "worst") {
      by_state <- with(fd, split(fd, state))
      ordered  <- list()
      for (i in seq_along(by_state)){
        by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                             by_state[[i]][, "hospital"], 
                                             decreasing = TRUE), ]
        ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else {
      stop('invalid num')
    }
  }
  return(output)
}
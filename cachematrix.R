## ProgrammingAssignment2


## This function creates a special "matrix" object that can 
## cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inverseM<-NULL
  set<-function(y)
  {
    x<<-y
    inverseM<<-NULL
  }
  get<-function()x
  setinverseM<-function(inverse) inverseM<<-inverse
  getinverseM<-function()inverseM
  list(set=set,get=get,setinverseM=setinverseM,getinverseM=getinverseM)
  
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated 
## (and the matrix has not changed), then cacheSolve should retrieve 
## the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inverseM<-x$getinverseM
  if(!is.null(inverseM))
  {
    message("get cache data")
    return(inverseM)
  }
  matrix.data<-x$getinverseM()
  inverseM=solve(mat.data,...)
  return(inverseM)
}
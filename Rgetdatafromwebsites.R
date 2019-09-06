con=url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode=readLines(con)
close(con)
htmlCode
#######
library(XML)
url="http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
HTML<-htmlTreeParse(url,useInternalNodes =TRUE )
xpathApply(HTML,"//tittle",xmlValue)
#######
library(httr)
html2=GET(url)
conten2=content(html2,as="text")
parsedHtml=htmlParse(content2,asText = TRUE)
xpathApply(parsedHtml,"//tittle",xmlValue)
########WEB SET WITH PASSWORDS
pg1=GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg1
names(pg1)
####using handles
google=handle("http://google.com")
pg1=GET(handle=google,path="/")
pg2=GET(handle=google,path="search")
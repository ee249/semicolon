# 크롤링 by 수이

### 이마트 크롤링(동적크롤링) - 서울만

```R
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url <- "https://store.emart.com/branch/list.do"
remDr$navigate(url)
seoulbtn <- remDr$findElement(using='css','#area_A > a')
seoulbtn$clickElement()
storebtn <- remDr$findElement(using='css','#branchType > option:nth-child(2)')
storebtn$clickElement()


#branchList > li:nth-child(1)
#branchList > li:nth-child(1) > a
#branchList > li:nth-child(17) > a
#branchList > li:nth-child(29) > a
#주소
#conts > div > div.map-wrap > div.branch-info > div.branch-info1 > ul > li:nth-child(2) > dl > dd:nth-child(2)
repl<-NULL
sname <- NULL
saddr <- NULL
for (i in 1:30) {
  css2<-paste0('#branchList > li:nth-child(', i ,') > a')
  storename<-remDr$findElement(using ="css selector",css2)
  storename$clickElement()
  Sys.sleep(2)
  css3 <- '#conts > div > div.store-intro > div.store-header > h2'
  css4 <- ' #conts > div > div.map-wrap > div.branch-info > div.branch-info1 > ul > li:nth-child(2) > dl > dd:nth-child(4)'
  storeaddr<-remDr$findElements(using ="css selector",css3)
  repl3 <-sapply(storeaddr,function(x){x$getElementText()})
  #print(repl3)
  sname<-rbind(sname, unlist(repl3))
  storeaddr<-remDr$findElements(using ="css selector",css4)
  repl4 <-sapply(storeaddr,function(x){x$getElementText()})
  #print(repl4)
  saddr<-rbind(saddr, unlist(repl4))
}

df <- data.frame(cbind(sname, saddr))
write.csv(df, "emart.csv")
getwd()
```





## 신세계 백화점 크롤링(정적크롤링) - 전지점

### SC00001 ~ SC00013 (SC00004 제외)

```R
library(httr)
library(rvest)
library(XML)
addrxpath <- '//*[@id="STORE_LOCATION"]/div[2]/div[2]/div[1]/div[2]/span/text()'
namexpath <- '//*[@id="STORE_COMMON_INFO"]/ul/li[1]/div[1]/div/span'
dname <- NULL
daddr <- NULL
for(i in 1:3){
  mainurl <- paste0('https://www.shinsegae.com/store/main.do?storeCd=SC000',sprintf("%02d", i))
  doc <- GET(mainurl, add_headers("Content_Type" = "application/xml"))
  doc2 <- htmlParse(doc, encoding="UTF-8")
  #백화점 명
  tmp1<-  gsub(pattern = " ", replacement = "", x = xpathSApply(doc2, namexpath, xmlValue))
  dname <-rbind(dname, tmp1)
  #주소
  tmp2<- xpathSApply(doc2, addrxpath, xmlValue)
  daddr<-rbind(daddr, tmp2)
}

for(i in 5:13){
  mainurl <- paste0('https://www.shinsegae.com/store/main.do?storeCd=SC000',sprintf("%02d", i))
  doc <- GET(mainurl, add_headers("Content_Type" = "application/xml"))
  doc2 <- htmlParse(doc, encoding="UTF-8")
  #백화점 명
  tmp1<-  gsub(pattern = " ", replacement = "", x = xpathSApply(doc2, namexpath, xmlValue))
  dname <-rbind(dname, tmp1)
  #주소
  tmp2<- xpathSApply(doc2, addrxpath, xmlValue)
  daddr<-rbind(daddr, tmp2)
}

df2<- data.frame(cbind(dname, daddr))
write.csv(df2, "ssgd.csv")
```



## GS편의점(동적크롤링) - 서울만

```R
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url <- 'http://gs25.gsretail.com/gscvs/ko/store-services/locations'
remDr$navigate(url)
seoulgs <- remDr$findElement(using='css','#stb1 > option:nth-child(2)')
seoulgs$clickElement()
Sys.sleep(2)
#pagingTagBox > a.next
#pagingTagBox > a.next
gsnamelist <- NULL
gsaddrlist <- NULL
for(i in 1:599){ #page
  for(j in 1:5){ #list
    #매장명
    gs1 <- paste0('#storeInfoList > tr:nth-child(',j,') > td:nth-child(1) > a')
    gsname<-remDr$findElements(using ="css selector",gs1)
    gsname <-sapply(gsname,function(x){x$getElementText()})
    gsnamelist <- rbind(gsnamelist, gsname)
    

    gs2 <- paste0('#storeInfoList > tr:nth-child(',j,') > td:nth-child(2) > a')
    gsaddr<-remDr$findElements(using ="css selector",gs2)
    gsaddr <-sapply(gsaddr,function(x){x$getElementText()})
    gsaddrlist <- rbind(gsaddrlist, gsaddr)

  }
  nextbtn <- remDr$findElement(using='css','#pagingTagBox > a.next')
  nextbtn$clickElement()
  Sys.sleep(2)
}

df3 <- data.frame(unlist(gsnamelist), unlist(gsaddrlist))
write.csv(df3, "gs.csv")
```







## 세븐일레븐(동적크롤링) - 서울만

```R
url <- "http://www.7-eleven.co.kr/"
remDr$navigate(url)

#점포찾기 메뉴 버튼 클릭
findcss<- '#header > div > div > div.head_util > a.util_store.store_open'
findbtn <- remDr$findElement(using='css',findcss)
findbtn$clickElement()
Sys.sleep(2)

#서울시 xx구 css
gucss <-'#storeLayGu'
#구리스트 뽑아오기
gulist <- remDr$findElements(using='css',gucss)
gulist <-sapply(gulist,function(x){x$getElementText()})
gulist <- unlist(strsplit(unlist(gulist), '\n'))[-1]
length(gulist) #25
gulist[1]

seven11name <- NULL
seven11addr <- NULL
for(i in 2:26){
  print(gulist[i])
  #구별 검색
  gu <- paste0('#storeLayGu > option:nth-child(',i,')')
  gubtn <- remDr$findElement(using='css',gu)
  gubtn$clickElement()
  Sys.sleep(2)
  #검색 버튼 css
  scss <- '#storeButton1'
  searchbtn <- remDr$findElement(using='css',scss)
  searchbtn$clickElement()
  Sys.sleep(2)
  #리스트 첫번째 원소
  #매장명
  slist <- '#storeForm > div:nth-child(4) > div.list_stroe > ul > li > a'
  slist <- remDr$findElements(using='css',slist)
  slist <- sapply(slist,function(x){x$getElementText()})
  strsplit(unlist(slist), '\n')->slist

  seven11name <- rbind(data.frame(seven11name), data.frame(sapply(slist, function(x){x[1]})))
  seven11addr <- rbind(data.frame(seven11addr), data.frame(sapply(slist, function(x){x[2]})))

}
df4 <- data.frame(seven11name, seven11addr)
write.csv(df4, "seven11_2.csv")
```


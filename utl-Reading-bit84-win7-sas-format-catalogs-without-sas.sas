Reading 64bit win7 sas format catalogs without sas                                                                                      
                                                                                                                                        
github                                                                                                                                  
https://tinyurl.com/ydfxhmny                                                                                                            
https://github.com/rogerjdeangelis/utl-Reading-bit84-win7-sas-format-catalogs-without-sas                                               
                                                                                                                                        
Appears to be a little buggy but worked for one simple format?                                                                          
Had some issues with mutiple formats, but miight be my issue?                                                                           
                                                                                                                                        
Can also be done in Python (maybe better?)                                                                                              
https://github.com/Roche/pyreadstat                                                                                                     
                                                                                                                                        
Win 7 64bit SAS 9.4M2 64bit                                                                                                             
                                                                                                                                        
                                                                                                                                        
INPUT                                                                                                                                   
=====                                                                                                                                   
                                                                                                                                        
FORMAT CATALOG                                                                                                                          
                                                                                                                                        
 d:/sd1/rfmt.sas7bcat                                                                                                                   
                                                                                                                                        
   ----------------------------------------------------------------------------                                                         
   |       FORMAT NAME: $SEX     LENGTH:    6   NUMBER OF VALUES:    2        |                                                         
   |   MIN LENGTH:   1  MAX LENGTH:  40  DEFAULT LENGTH:   6  FUZZ:        0  |                                                         
   |--------------------------------------------------------------------------|                                                         
   |START           |END             |LABEL  (VER. V7|V8   12OCT2018:12:40:04)|                                                         
   |----------------+----------------+----------------------------------------|                                                         
   |F               |F               |Female                                  |                                                         
   |M               |M               |Male                                    |                                                         
   ----------------------------------------------------------------------------                                                         
                                                                                                                                        
                                                                                                                                        
   SD1.CLASS total obs=5                                                                                                                
                                                                                                                                        
     NAME      SEX    AGE    HEIGHT    WEIGHT                                                                                           
                                                                                                                                        
    Alfred      M      14     69.0      112.5                                                                                           
    Alice       F      13     56.5       84.0                                                                                           
    Barbara     F      13     65.3       98.0                                                                                           
    Carol       F      14     62.8      102.5                                                                                           
    Henry       M      14     63.5      102.5                                                                                           
                                                                                                                                        
                                                                                                                                        
         Variables in Creation Order                                                                                                    
                                                                                                                                        
   #    Variable    Type    Len    Format                                                                                               
                                                                                                                                        
   1    NAME        Char      8                                                                                                         
   2    SEX         Char      1    $SEX.   ==> formats                                                                                  
   3    AGE         Num       8                                                                                                         
   4    HEIGHT      Num       8                                                                                                         
   5    WEIGHT      Num       8                                                                                                         
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
EXAMPLE OUTPUT FROM OPEN SOURCE R                                                                                                       
-----------------------------------                                                                                                     
                                                                                                                                        
WORK.FMTSEX total obs=2                                                                                                                 
                                                                                                                                        
Obs    FORMAT        HAVEN         FROM      TO                                                                                         
                                                                                                                                        
 1      $SEX     haven_labelled     M      Male                                                                                         
 2      $SEX     haven_labelled     F      Female                                                                                       
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
PROCESS                                                                                                                                 
=======                                                                                                                                 
                                                                                                                                        
* R would be better without rownames of factors (and other structures)                                                                  
Less is More;                                                                                                                           
                                                                                                                                        
%utl_submit_r64('                                                                                                                       
                                                                                                                                        
library(haven);                                                                                                                         
library(SASxport);                                                                                                                      
                                                                                                                                        
apycat <- read_sas("d:/sd1/class.sas7bdat", catalog_file="d:/sd1/rfmt.sas7bcat");                                                       
                                                                                                                                        
fmtsex<-as.data.frame(attributes(apycat$SEX));                                                                                          
                                                                                                                                        
fmtsex[] <- lapply(fmtsex, as.character);                                                                                               
                                                                                                                                        
colnames(fmtsex)<-c("FORMAT","HAVEN","FROM");                                                                                           
fmtsex$TO<-rownames(fmtsex);                                                                                                            
                                                                                                                                        
write.xport(fmtsex,file="d:/xpt/fmtsex.xpt");                                                                                           
');                                                                                                                                     
                                                                                                                                        
libname fmtsex xport "d:/xpt/fmtsex.xpt" ;                                                                                              
                                                                                                                                        
data fmtsex;                                                                                                                            
  set fmtsex.fmtsex;                                                                                                                    
run;quit;                                                                                                                               
                                                                                                                                        
proc print data=fmtsex;                                                                                                                 
run;quit;                                                                                                                               
                                                                                                                                        
                                                                                                                                        
LOG                                                                                                                                     
---                                                                                                                                     
                                                                                                                                        
> library(haven);library(SASxport);                                                                                                     
apycat <- read_sas("d:/sd1/class.sas7bdat", catalog_file="d:/sd1/rfmt.sas7bcat");                                                       
fmtsex<-as.data.frame(attributes(apycat$SEX));                                                                                          
fmtsex[]<- lapply(fmtsex, as.character);                                                                                                
colnames(fmtsex)<-c("FORMAT","HAVEN","FROM");                                                                                           
fmtsex$TO<-rownames(fmtsex);                                                                                                            
write.xport(fmtsex,file="d:/xpt/fmtsex.xpt");                                                                                           
>                                                                                                                                       
NOTE: 3 lines were written to file PRINT.                                                                                               
package 'SASxport' was built under R version 3.3.3                                                                                      
NOTE: 2 records were read from the infile RUT.                                                                                          
      The minimum record length was 2.                                                                                                  
      The maximum record length was 321.                                                                                                
                                                                                                                                        
                                                                                                                                        
MPRINT(UTL_SUBMIT_R64):   filename rut clear;                                                                                           
NOTE: Fileref RUT has been deassigned.                                                                                                  
MPRINT(UTL_SUBMIT_R64):   filename r_pgm clear;                                                                                         
NOTE: Fileref R_PGM has been deassigned.                                                                                                
MPRINT(UTL_SUBMIT_R64):   * use the clipboard to create macro variable;                                                                 
SYMBOLGEN:  Macro variable RETURNVAR resolves to N                                                                                      
MLOGIC(UTL_SUBMIT_R64):  %IF condition %upcase(%substr(&returnVar.,1,1)) ne N is FALSE                                                  
MLOGIC(UTL_SUBMIT_R64):  Ending execution.                                                                                              
1002  libname fmtsex xport "d:/xpt/fmtsex.xpt" ;                                                                                        
NOTE: Libref FMTSEX was successfully assigned as follows:                                                                               
      Engine:        XPORT                                                                                                              
      Physical Name: d:\xpt\fmtsex.xpt                                                                                                  
1003  data fmtsex;                                                                                                                      
1004    set fmtsex.fmtsex;                                                                                                              
1005  run;                                                                                                                              
                                                                                                                                        
NOTE: There were 2 observations read from the data set FMTSEX.FMTSEX.                                                                   
NOTE: The data set WORK.FMTSEX has 2 observations and 4 variables.                                                                      
NOTE: DATA statement used (Total process time):                                                                                         
      real time           0.06 seconds                                                                                                  
                                                                                                                                        
1005!     quit;                                                                                                                         
1006  proc print data=fmtsex;                                                                                                           
1007  run;                                                                                                                              
                                                                                                                                        
NOTE: There were 2 observations read from the data set WORK.FMTSEX.                                                                     
NOTE: PROCEDURE PRINT used (Total process time):                                                                                        
      real time           0.06 seconds                                                                                                  
                                                                                                                                        
1007!     quit;                                                                                                                         
                                                                                                                                        
*                _              _       _                                                                                               
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _                                                                                        
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |                                                                                       
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |                                                                                       
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|                                                                                       
                                                                                                                                        
;                                                                                                                                       
                                                                                                                                        
%utlfkil(d:/sd1/rfmt.sas7bcat); * develoopment only;                                                                                    
                                                                                                                                        
libname sd1 'd:/sd1';                                                                                                                   
                                                                                                                                        
proc format library=sd1.rfmt;                                                                                                           
  value $sex                                                                                                                            
     "M" = "Male"                                                                                                                       
     "F" = "Female"                                                                                                                     
  ;                                                                                                                                     
run;quit;                                                                                                                               
                                                                                                                                        
options fmtsearch=(work sd1.rfmt);                                                                                                      
                                                                                                                                        
options validvarname=upcase;                                                                                                            
libname sd1 "d:/sd1";                                                                                                                   
data sd1.class;                                                                                                                         
  set sashelp.class(obs=5);                                                                                                             
  format sex $sex.;                                                                                                                     
run;quit;                                                                                                                               
                                                                                                                                        
proc format lib=sd1.rfmt fmtlib;                                                                                                        
run;quit;                                                                                                                               
                                                                                                                                        
libname sd1 clear;                                                                                                                      
                           

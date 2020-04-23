
clear all; 
clc; 
close all; 

 HISTORY ={
    2 , { 'TRUE','FALSE' }};
  
 CVP ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 PCWP ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 HYPOVOLEMIA ={
    2 , { 'TRUE','FALSE' }};

 LVEDVOLUME ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 LVFAILURE ={
    2 , { 'TRUE','FALSE' }};

 STROKEVOLUME ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 ERRLOWOUTPUT ={
    2 , { 'TRUE','FALSE' }};

 HRBP ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 HREKG ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 ERRCAUTER ={
    2 , { 'TRUE','FALSE' }};

 HRSAT ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 INSUFFANESTH ={
    2 , { 'TRUE','FALSE' }};

 ANAPHYLAXIS ={
    2 , { 'TRUE','FALSE' }};

 TPR ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 EXPCO2 ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 KINKEDTUBE ={
    2 , { 'TRUE','FALSE' }};

 MINVOL ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 FIO2 ={
    2 , { 'LOW', 'NORMAL' }};

 PVSAT ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 SAO2 ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 PAP ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 PULMEMBOLUS ={
    2 , { 'TRUE','FALSE' }};

 SHUNT ={
    2 , { 'NORMAL', 'HIGH' }};

 INTUBATION ={
    3 , { 'NORMAL', 'ESOPHAGEAL', 'ONESIDED' }};

 PRESS ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 DISCONNECT ={
    2 , { 'TRUE','FALSE' }};

 MINVOLSET ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 VENTMACH ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 VENTTUBE ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 VENTLUNG ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 VENTALV ={
    4 , { 'ZERO', 'LOW', 'NORMAL', 'HIGH' }};

 ARTCO2 ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 CATECHOL ={
    2 , { 'NORMAL', 'HIGH' }};

 HR ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 CO ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }};

 BP ={
    3 , { 'LOW', 'NORMAL', 'HIGH' }}; 


nnames = who; 

graph = cell(length(who)-1,1); 

for  ii = 1:length(nnames) 
    
    node = cell(1,6); 
 
    name = nnames{ii}; 
    content = eval(nnames{ii}); 
    
    node{1} = nnames{ii}; 
    node{2} = content{1}; 
    node{3} = content{2}; 
 
    graph{ii} = node;
    
end 

clearvars -except graph; 

tables;  

for ii = 1:length(graph) 
    
    dat = eval(graph{ii}{1});
    
    if (length(dat) == 1)
        
        graph{ii}(6) = dat; 
        
    else 
    
         jj = 1; 
         
         while (ischar(dat{jj})) 
             
            jj = jj + 1; 
             
         end 
         
         jj = jj - 1; 
         
         graph{ii}{4} = dat(1:jj); 
                      
         tbl = dat{jj + 1};       
         
         graph{ii}{5} = tbl(:,1:end-graph{ii}{2}); 

         graph{ii}{6} = cell2mat(tbl(:,end-graph{ii}{2}+1:end));  
         
       
    end
    
end 

clearvars -except graph; 

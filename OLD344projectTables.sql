-- Tables for 344 Project

/* DROP STATEMENTS */
DROP TABLE per CASCADE CONSTRAINTS;
DROP TABLE dem CASCADE CONSTRAINTS;
DROP TABLE email CASCADE CONSTRAINTS;
DROP TABLE hos CASCADE CONSTRAINTS;
DROP TABLE stu CASCADE CONSTRAINTS;
DROP TABLE par CASCADE CONSTRAINTS;
DROP TABLE phn CASCADE CONSTRAINTS;
DROP TABLE emg CASCADE CONSTRAINTS;
DROP TABLE inc CASCADE CONSTRAINTS;
DROP TABLE medin CASCADE CONSTRAINTS;
DROP TABLE addr CASCADE CONSTRAINTS;
DROP TABLE brn CASCADE CONSTRAINTS;
DROP TABLE stdoc CASCADE CONSTRAINTS;
DROP TABLE sdev CASCADE CONSTRAINTS;
DROP TABLE serv CASCADE CONSTRAINTS;
DROP TABLE ori CASCADE CONSTRAINTS;
DROP TABLE data CASCADE CONSTRAINTS;
DROP TABLE off CASCADE CONSTRAINTS;
DROP TABLE econ CASCADE CONSTRAINTS;
DROP TABLE pro CASCADE CONSTRAINTS:
DROP TABLE med CASCADE CONSTRAINTS;
DROP TABLE sdoc CASCADE CONSTRAINTS;
DROP TABLE inst CASCADE CONSTRAINTS;

/* CREATE STATEMENTS */

--PERSON TABLE
CREATE TABLE pers (
persid VARCHAR2 (35),
persfname VARCHAR2 (35) NOT NULL,
persmname VARCHAR2 (35), --NULLABLE SOME MAY NOT LIST A MIDDLE NAME
perslname VARCHAR2 (35) NOT NULL,
	
CONSTRAINT pers_pk PRIMARY KEY (persid));
  
--DEMOGRAPHIC TABLE  
CREATE TABLE dem (
stuID NUMBER (10),
demeth VARCHAR2 (35) NOT NULL, -- ETHNICITY
demgen VARCHAR2 (1) NOT NULL, -- GENDER

CONSTRAINT dem_demID_pk PRIMARY KEY (stuID)
CONSTRAINT dem_demID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));

--EMAIL TABLE
CREATE TABLE email (
emailID VARCHAR2 (35),
emailus VARCHAR2 (20) NOT NULL,
emaildom VARCHAR2 (20)NOT NULL,
  
CONSTRAINT email_emailID_pk PRIMARY KEY (emailID)
CONSTRAINT email_emailID_fk FOREIGN KEY (emailID) REFERENCES email(emailID));

--HOSPITAL TABLE
CREATE TABLE hos (
stuID NUMBER (10),
hosID NUMBER (10)NOT NULL,
hosname VARCHAR2 (35) NOT NULL,                             
hosprim VARCHAR2 (1) NOT NULL, --PRIMARY (Y/N)  
hosphn NUMBER (10) NOT NULL, --PHONE NUMBER  

CONSTRAINT hos_pk PRIMARY KEY (stuID, hosID)  
CONSTRAINT hos_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT hos_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));
  
-- STUDENT TABLE
CREATE TABLE stu (                          
stuID NUMBER (10),
orgID NUMBER (10) NOT NULL, --ORGANIZATON ID
stuyr VARCHAR2 (35) NOT NULL, -- YEAR IN SCHOOL (JUNIOR, SENIOR, ETC)  
stulunch VARCHAR2 (1) NOT NULL, -- LUNCH
sturet VARCHAR2 (1) NOT NULL,   -- RETAINED (CHECK)
stutru VARCHAR2 (1) NOT NULL,   --TRUANCY 
stugradecomm VARCHAR2 (1) NOT NULL, --GRADE COMMENTS
stugradesatis VARCHAR2 (1) NOT NULL,  --GRADE SATISFIED?
stuhomewrk VARCHAR2 (35) NOT NULL,  --HOMEWORK
stuserviceID VARCHA2 (35) NOT NULL,--CHECK THIS
  
CONSTRAINT stu_perID_pk PRIMARY KEY(perID),
CONSTRAINT stu_perID_fk FOREIGN KEY (perID) REFERENCES per(perID),
CONSTRAINT stu_servID_fk FOREIGN KEY (servID) REFERENCES serv(servID) -- MAKE THIS TABLE
CONSTRAINT stu_orgID_fk FOREIGN KEY (orgID) REFERENCES org(orgID));
-- EMERGENCY CONTACT TABLE
CREATE TABLE par (
stuID NUMBER (10),
emgID NUMBER (10) NOT NULL, --EMERGENCY ID
parrelation VARCHAR2 (35) NOT NULL, --RELATION TO STUDENT

CONSTRAINT par_pk PRIMARY KEY(stuID, emgID)
CONSTRAINT par_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT dem_emgID_fk FOREIGN KEY (emgID) REFERENCES par(emgID));  
  
-- PHONE TABLE  
CREATE TABLE phn (
phnID VARCHAR2 (35) NOT NULL,
phntype VARCHAR2 (1) NOT NULL,
phncntry NUMBER (1) NOT NULL,
phnarea NUMBER (1) NOT NULL,
phnexc NUMBER (35) NOT NULL,

CONSTRAINT phn_phnID_pk PRIMARY KEY(phnID)) ;

-- EMERGENCY TABLE  
CREATE emg (
emgID VARCHAR2 (35),    
emgdesc VARCHAR2 (35) NOT NULL,

CONSTRAINT emg_emgID_pk PRIMARY KEY(emgID)) ;
-- SPECIAL SERVICES TABLE
CREATE TABLE serv (
stuID NUMBER (10),  
servID NUMBER (10),
  
CONSTRAINT serv_pk PRIMARY KEY (stuID, servID)
CONSTRAINT serv_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT serv_servID_fk FOREIGN KEY (servID) REFERENCES serv(servID));

--Income Table
CREATE TABLE inc (
perID NUMBER (10),                    
guardID NUMBER (10),  
incfamsi NUMBER (10) NOT NULL,  --FAMILY SIZE
incinc NUMBER (10) NOT NULL, --   FAMILY INCOME
incmili VARCHAR2 (1) NOT NULL,  --MILITARY STATUS (Y/N)
incbran VARCHAR2 (15) NOT NULL, --BRANCH
inclivew VARCHAR2 (15) NOT NULL,--MEMBER LIVES WITH
   
CONSTRAINT inc_pk PRIMARY KEY(perID, guardID),
CONSTRAINT inc_perID_fk FOREIGN KEY (perID) REFERENCES per(perID)  
CONSTRAINT inc_guardID_fk FOREIGN KEY (guardID) REFERENCES inc(guardID));  
  
--MEDICAL INFO TABLE
CREATE TABLE medin (
stuID NUMBER (10),
medinID NUMBER (10),
medindate DATE, -- DATE OF LAST VISIT
medinupda VARCHAR2 (1) --IMMUNIZATION UPDATE (Y/N)  
  
CONSTRAINT medin_stuID_pk PRIMARY KEY (stuID)
CONSTRAINT medin_medinID_pk PRIMARY KEY (medinID)  
CONSTRAINT medin_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));  
  
  
-- ADDRESS TABLE   
CREATE TABLE addr (
addrID NUMBER (10),
addrstreet VARCHAR2 (35) NOT NULL, 
addrcity VARCHAR2 (35) NOT NULL,  
addrzip NUMBER (5) NOT NULL,  
  
CONSTRAINT addr_addrID_pk PRIMARY KEY (addrID)) ;  

--MILITARY BRANCH TABLE
CREATE TABLE brn (
brnID NUMBER (10),
brnname VARCHAR2(35) NOT NULL,
  
CONSTRAINT brn_brnID_pk PRIMARY KEY (brnID));  

--STUDENT DOCTOR TABLE
CREATE TABLE stdoc (
stuID NUMBER (10),
docID NUMBER (10),
 
CONSTRAINT stdoc_pk PRIMARY KEY (stuID, docID)
CONSTRAINT stdoc_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT stdoc_docID_fk FOREIGN KEY (docID) REFERENCES doc(docID));
  
--SOCIAL DEVELOPMENT TABLE 
CREATE TABLE sdev (
stuID NUMBER (10),
sdevstress VARCHAR2 (1) NOT NULL, --STRESS (Y/N?)
sdevdral VARCHAR2 (1) NOT NULL, --DRUG AL PROBLEMS IN FAMILY (Y/N?)
sdevleg VARCHAR2 (1) NOT NULL, --LEGAL ISSUES (Y/N)
sdevbull VARCHAR2 (1) NOT NULL, --BULLYING ISSUES

CONSTRAINT sdev_stuID_pk PRIMARY KEY (stuID)
CONSTRIANT sdev_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));
  
--MEMBERSHIP RELEASE FORM TABLE
CREATE TABLE mr (
stuID NUMBER (10),
mrdatsig DATE NOT NULL,     --DATE SIGNED
mrliab VARCHAR2 (1)NOT NULL, --LIABILITY Y/N
mrtrans VARCHAR2 (1)NOT NULL, --TRANSPORTATION
mrpho VARCHAR2 (1) NOT NULL, --PHOTO/VIDEO Y/N
mracadem VARCHAR2 (1) NOT NULL, -- ACADEMIC INFO RELEASE Y/N
mrcomp VARCHAR2 (1) NOT NULL, -- COMPUTER USE Y/N   
mrauthl VARCHAR2 (1) NOT NULL, -- AUTHORIZED TO LEAVE Y/N
mrmemsig VARCHAR2 (1) NOT NULL -- MEMBER SIGNATURE Y/N
mrparsig VARCHAR2 (1) NOT NULL, --PARENT SIGNATURE Y/N
  
CONSTRAINT mr_pk PRIMARY KEY (stuID));   
--Emergency Contact TABLE 
CREATE TABLE econ (
stuID NUMBER (4),
emgID NUMBER (4),                                            
econrel VARCHAR2 (35)NOT NULL, --RELATIONSHIP TO STUDENT  
econcall VARCHAR2 (1)NOT NULL, --CALL IN CASE OF EMG?
econauth VARCHAR2 (1) NOT NULL, --AUTHORIZED TO PICKUP 

CONSTRAINT econ_pk PRIMARY KEY (stuID, emgID)
CONSTRAINT econ_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT econ_emgID_fk FOREIGN KEY (emgID) REFERENCES emg(emgID));

--OFFICE USE TABLE
CREATE TABLE off
empID NUMBER (10), -- EMPLOYEE ID
stuID NUMBER (10),  -- STUDENT ID
offmemst VARCHAR2 (1) NOT NULL, --CHECK THIS MEMBER STATUS (GUEST, NEW, RENEW)  
offpay VARCHAR2(35) NOT NULL, -- PAYMENT METHOD (PAID, CASH, CHECK, MO, SCHOLARSHIP)
offpaya NUMBER(10) NOT NULL, --PAYMENT AMOUNT 
  
CONSTRAINT off_pk PRIMARY KEY (empID, stuID)
CONSTRIANT off_empID_fk FOREIGN KEY (empID) REFERENCES emp(empID)
CONSTRIANT off_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));  
  
--DATA ENTRY TABLE
CREATE TABLE data (
empID NUMBER (10), -- EMPLOYEE ID
stuID NUMBER (10),  -- STUDENT ID
datadatr DATE NOT NULL, -- DATE RECEIVED
datadate DATE NOT NULL, -- DATE ENTERED 
  
CONSTRAINT off_pk PRIMARY KEY (empID, stuID)
CONSTRIANT off_empID_fk FOREIGN KEY (empID) REFERENCES emp(empID)
CONSTRIANT off_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));    
  
--ORIENTATION TABLE
CREATE TABLE ori (  
empID NUMBER (10),
stuID NUMBER (10), 
orida DATE NOT NULL, --ORIENTATION DATE
oriti DATE NOT NULL, --ORIENTATION TIME
oricom VARCHAR2 (1) NOT NULL, --ORIENTATION COMPLETE (Y/N)
  
CONSTRAINT ori_pk PRIMARY KEY (empID, stuID)
CONSTRIANT ori_empID_fk FOREIGN KEY (empID) REFERENCES emp(empID)
CONSTRIANT ori_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));    
  
--PLACE OF EMPLOYMENT TABLE
CREATE TABLE empp
perID NUMBER (10),
emppna VARCHAR2 (35) NOT NULL, --EMPLOYMENT PLACE/BUSINESS/COMPANY NAME

CONSTRAINT empp_perID_pk PRIMARY KEY(perID),
CONSTRAINT empp_perID_fk FOREIGN KEY (perID) REFERENCES per(perID));
  
  
--Attendance Table                 
CREATE TABLE att (
stuID NUMBER (10),
attdate DATE NOT NULL, --ATTENDANCE DATE
attchkin DATE NOT NULL, --CHECK IN
attchko DATE NOT NULL, --CHECK OUT
  
CONSTRAINT att_stuID_pk PRIMARY KEY (stuID)  
CONSTRIANT att_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)); 

--AUTHORIZATION TABLE
CREATE TABLE auth (
emgID NUMBER(10),
emgdesc VARCHAR2 (50) NOT NULL,

CONSTRAINT auth_emgID_pk PRIMARY KEY(emgID)
CONSTRAINT auth_emgID_fk FOREIGN KEY (emgID) REFREENCES emg(emgID));

--EMAIL TABLE
CREATE TABLE ema (
emaID NUMBER (10),
emauser VARCHAR2 (25),
emadom VARCHAR2 (25)
  
CONSTRAINT ema_emaID_pk PRIMARY KEY(emaID)
CONSTRAINT ema_emaID_fk FOREIGN KEY (emaID) REFREENCES ema(emaID));  

--STUDENT DOCTOR TABLE
CREATE TABLE sdoc (
stuID NUMBER (10),  
docID NUMBER (10),    
  
CONSTRAINT sdoc_pk PRIMARY KEY (stuID, docID)                   
CONSTRAINT sdoc_stuID_fk FOREIGN KEY (stuID)
CONSTRAINT sdoc_docID_fk FOREIGN KEY (docID));

--SPECIAL INSTRUCTIONS TABLE
CREATE TABLE inst (
stuID NUMBER (10),
medID NUMBER (10),
instdesc VARCHAR2 (35)NOT NULL, --DESCRIPTION  
  
CONSTRAINT inst_pk PRIMARY KEY (stuID, medID)  
CONSTRAINT inst_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID)
CONSTRAINT inst_medID_fk FOREIGN KEY (medID) REFERENCES med(medID));

--MEDICATION TABLE
CREATE TABLE med (
medID NUMBER (10),
hosname VARCHAR2 (10)NOT NULL, --name
medamt NUMBER (10) NOT NULL, --amount 
meddir VARCHAR2 (35) NOT NULL, --HOW TO TAKE (MOUTH, EYE DROPS, EAR, ON SKIN, ETC)
medti DATE NOT NULL, -- TIME/S OF DAY
medre VARCHAR2 (35) NOT NULL, -- REASON
  
CONSTRAINT med_medID_pk PRIMARY KEY (medID));    

--PROBLEM TABLE
CREATE TABLE pro (
proID NUMBER (10),
stuID NUMBER (10)  NOT NULL,
prospec VARCHAR2 (35) NOT NULL, 
  
CONSTRAINT pro_pk PRIMARY KEY (proID)
CONSTRAINT pro_stuID_fk FOREIGN KEY (stuID) REFERENCES stu(stuID));

--ORGANIZATION TABLE

CREATE TABLE org (
orgID NUMBER (10),
	

--INSERT STATEMENTS
--PERSON
INSERT INTO pers 
  VALUES (5001, 'Noah', 'Wetzel','James');
  
INSERT INTO pers
  VALUES (5002, 'Jordan', 'Jansen','Fredrick'); 
  
INSERT INTO pers 
  VALUES (5003, 'Ian', 'Wetzel','Charles');
  
INSERT INTO pers 
  VALUES (5004, 'Justin', 'Lorentz','Allen');  
  
INSERT INTO pers 
  VALUES (5005, 'Rachel', 'Stout','Marie');
  
INSERT INTO pers 
  VALUES (5006, 'Erin', 'Wetzel','Charlene');

INSERT INTO pers 
  VALUES (5007, 'Sunny', '', 'Chen');
  
INSERT INTO pers 
  VALUES (5008, 'Jacob', 'Maurer','Peter');

INSERT INTO pers 
  VALUES (5009, 'Yong Sheng', '', 'Lai');

INSERT INTO pers 
  VALUES (5010, 'Mark', 'Smith', 'Brewer');

INSERT INTO pers 
  VALUES (5011, 'Sarah', 'Adam', 'Lee');

INSERT INTO pers 
  VALUES (5012, 'Patricia', 'Jacobsen' ,'Pweter');

INSERT INTO pers 
  VALUES (5013, 'Adam', 'Martin' ,'Jake');

INSERT INTO pers 
  VALUES (5014, 'Eli', '','Behling');

INSERT INTO pers 
  VALUES (5015, 'Sam', 'Paul','Smith');

INSERT INTO pers 
  VALUES (5016, 'Sandy', '','Wong');
  
INSERT INTO pers 
  VALUES (5017, 'John', 'Jacobs','James');
  
INSERT INTO pers 
  VALUES (5018, 'Adam', 'Seth','Johnson');
  
INSERT INTO pers 
  VALUES (5019, 'Sam', 'David','Heath');
  
INSERT INTO pers 
  VALUES (5020, 'Samantha', 'Erin','Dunbar');

INSERT INTO pers 
  VALUES (5021, 'Eli', '','Manning');
--DEMOGRAPHIC 

INSERT INTO dem
  VALUES (2001, 'M', 16-OCT-1996);
  
INSERT INTO dem
  VALUES (2002, 'M', 01-JAN-1950);
  
INSERT INTO dem
  VALUES (2003, 'M', 20-APR-1994);
  
INSERT INTO dem
  VALUES (2004, 'M', 25-APR-1997);  
  
INSERT INTO dem
  VALUES (2005, 'F', 15-JUN-1997);  
  
INSERT INTO dem
  VALUES (2006, 'F', 30-SEP-1998);
  
 INSERT INTO dem
  VALUES (2007, 'F', 25-APR-1997); -- check date
  
INSERT INTO dem
  VALUES (2008, 'M', 28-JUN-1945); 
	
INSERT INTO dem
  VALUES (2009, 'M', 30-APR-1992);
	
INSERT INTO dem
  VALUES (2010, 'F', 21-JUL-1992);
	
INSERT INTO dem
  VALUES (2011, 'F', 10-APR-1994);	
  
--EMAIL  
INSERT INTO email
  VALUES ('WETZELNJ5708@uwec.edu', 'WETZELNJ5708', 'uwec.edu')
  
INSERT INTO email
  VALUES ('jordan@uwec.edu', 'j', 'uwec.edu') --
  
INSERT INTO email
  VALUES ('ianwtz@gmail.com', 'ianwtz', 'gmail.com')
  
INSERT INTO email
  VALUES ('LORENTJA6352@uwec.edu', 'LORENTJA6352', 'uwec.edu')  
  
INSERT INTO email
  VALUES ('rachel@uwec.edu', 'r', 'uwec.edu')     --
  
INSERT INTO email
  VALUES ('erin123@gmail.com', 'erin123', 'gmail.com')
  
INSERT INTO email
  VALUES ('sunny@uwec.edu', 's', 'uwec.edu')
  
INSERT INTO email
  VALUES ('jake@uwec.edu', 'jake', 'uwec.edu')   --
  
--PHONE DO WE NEED TO ADD PERSON ID?? 

INSERT INTO phn
  VALUES ('10001', 'C', '1', '920', 8583994) --Fix data type in create table
  
INSERT INTO phn
  VALUES ('10002', 'C', '1', '715', 7652134)  
  
INSERT INTO phn
  VALUES ('10003', 'C', '1', '920', 4562177)  
  
INSERT INTO phn
  VALUES ('10004', 'W', '1', '414', 8865432) 
  
INSERT INTO phn
  VALUES ('10005', 'C', '1', '952', 7775544) 
  
INSERT INTO phn
  VALUES ('10006', 'W', '1', '920', 3435612)  
  
INSERT INTO phn
  VALUES ('10007', 'C', '1', '920', 8583994) 
  
INSERT INTO phn
  VALUES ('10008', 'C', '1', '715', 7785656) 
  
  
--ADDRESS
INSERT INTO addr
  VALUES (5001, 'Niagara', 'Eau Claire', 54703);
  
INSERT INTO addr
  VALUES (5002, 'State', 'Madison', 53703);
  
INSERT INTO addr
  VALUES (5003, 'Sunset', 'Neenah', 54956);
  
INSERT INTO addr
  VALUES (5004, 'Allen', 'Chippewa Falls', 54729);  

INSERT INTO addr
  VALUES (5005, 'Gilbert', 'Eau Claire', 54701);
  
INSERT INTO addr
  VALUES (5006, 'Hartford', 'Milwaukee', 53211); 
  
INSERT INTO addr
  VALUES (5007, 'Gartfield', 'Eau Claire', 54701);
  
INSERT INTO addr
  VALUES (5008, 'University', 'Eau Claire', 54701);
   
--HOSPITAL

INSERT INTO hos 
  VALUES (stuID, hosID, hosname, hosprimary?, hosphn)
  
--STUDENT (stuID,stuorgID, student year inschool jun sen, student lunch y/n, student retained, stu grade comments, stu grades sat?, stu homework,stuservID)
INSERT INTO stu
  VALUES (2001, 6001, 'Junior', 'Y', 'N', ' ', 'Y', 'Math', 7001);
  
INSERT INTO stu
  VALUES (2002, 6002, 'Freshman', 'N', 'N', 'Would like to see extra work on sciences', 'N', 'Science', 7002); 
	
INSERT INTO stu
  VALUES (2003, 6003, 'Sophmore', 'N', 'Y', 'Would like to see extra time spend on gym/excercise', 'N', 'Gym', 7003); 	

INSERT INTO stu
  VALUES (2004, 6004, 'Senior', 'Y', 'N', ' ', 'Y', ' ', 7004); 

INSERT INTO stu
  VALUES (2005, 6005, 'Freshman', 'N', 'N', 'Needs extra time with math', 'Y', 'Math', 7005);

INSERT INTO stu
  VALUES (2006, 6006, 'Freshman', 'N', 'N', 'Would like to see extra time with science', 'N', 'Science', 7006);
	
INSERT INTO stu
  VALUES (2007, 6007, 'Sophmore', 'N', 'Y', '', 'Y', ' ', 7007); 	

INSERT INTO stu
  VALUES (2008, 6008, 'Junior', 'Y', 'N', 'Needs help with social studies', 'N', 'Social studies', 7008);

INSERT INTO stu
  VALUES (2009, 6009, 'Freshman', 'N', 'N', '', 'Y', 'Science', 7009);

INSERT INTO stu
  VALUES (2010, 6010, 'Senior', 'N', 'N', 'Needs help with nutrition education', 'Y', '', 7010);

	

--INSERT EMERGENCY CONTACT
INSERT INTO emg
	VALUES (1010, 5001, 'Brother', 'Y', 'Y', 'N');

INSERT INTO emg
	VALUES (1011, 5002, Friend, 'N', 'Y', 'N');

INSERT INTO emg
	VALUES (1012, 5003, Colleague, 'Y', 'N', 'Y');

INSERT INTO emg
	VALUES (1013, 5004, Cousin, 'Y', 'Y', 'N');

INSERT INTO emg
	VALUES (1014, 5005, Sister, 'Y', 'N', 'Y');

INSERT INTO emg
	VALUES (1015, 5006, Brother, 'N', 'N', 'Y');

INSERT INTO emg
	VALUES (1016, 5007, Wife, 'Y', 'Y', 'N');

--Income Table --FIX ID
INSERT INTO inc 
VALUES ( ?,5, 59000, N, father);

INSERT INTO inc 
VALUES ( ?,4, 69000, Y, father);

INSERT INTO inc 
VALUES ( ?,6, 120000, N,  Both Parents);

INSERT INTO inc 
VALUES ( ?,2, 88000, N, Mother);

INSERT INTO inc 
VALUES ( ?,3, 70000, N,  Guardian);

INSERT INTO inc 
VALUES ( ?,2, 30000, N,  Grandparent);

INSERT INTO inc 
VALUES ( ?,5, 90000, N,  Foster Parent);

INSERT INTO inc 
VALUES ( ?,7, 100000, N,  Relative);

	
--ATTENDANCE TABLE (2001, attendance date, check in date, check out date)
INSERT INTO att	
	VALUES (2001, 28-APR-2018, 28-APR-2018, 30-APR-2018);
	
INSERT INTO att	
	VALUES (2002, 17-MAR-2018, 10-MAR-2018, 30-APR-2018);	

INSERT INTO att	
	VALUES (2003, 04-FEB-2018, 02-JAN-2018, 07-FEB-2018);
	
INSERT INTO att	
	VALUES (2004, 28-OCT-2017, 14-OCT-2017, 30-OCT-2017);	
	
INSERT INTO att	
	VALUES (2005, 13-SEP-2017, 20-AUG-2016, 30-APR-2018);
	
INSERT INTO att	
	VALUES (2006, 22-NOV-2018, 01-NOV-2016, 23-NOV-2017);	
	
	
	

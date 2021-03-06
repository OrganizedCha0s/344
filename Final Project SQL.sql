-- Tables for IS 344 Project
--GROUP 9
--NOAH WETZEL, RACHEL STOUT, JIA CHAN, YONG SHENG, SUNNY CHEN

/* DROP STATEMENTS */
DROP TABLE per CASCADE CONSTRAINTS;
DROP TABLE dem CASCADE CONSTRAINTS;
DROP TABLE email CASCADE CONSTRAINTS;
DROP TABLE hos CASCADE CONSTRAINTS;
DROP TABLE stu CASCADE CONSTRAINTS;
DROP TABLE emg CASCADE CONSTRAINTS;
DROP TABLE phn CASCADE CONSTRAINTS;
DROP TABLE inc CASCADE CONSTRAINTS;
DROP TABLE medinfo CASCADE CONSTRAINTS;
DROP TABLE addr CASCADE CONSTRAINTS;
DROP TABLE brn CASCADE CONSTRAINTS;
DROP TABLE stdoc CASCADE CONSTRAINTS;
DROP TABLE socdev CASCADE CONSTRAINTS;
DROP TABLE stuserv CASCADE CONSTRAINTS;
DROP TABLE pro CASCADE CONSTRAINTS; 
DROP TABLE peraddr CASCADE CONSTRAINTS; 
DROP TABLE mr CASCADE CONSTRAINTS; 
DROP TABLE org CASCADE CONSTRAINTS; 
DROP TABLE parguar CASCADE CONSTRAINTS;  
DROP TABLE eth CASCADE CONSTRAINTS; 
DROP TABLE plofemp CASCADE CONSTRAINTS; 
DROP TABLE att CASCADE CONSTRAINTS; 
DROP TABLE med CASCADE CONSTRAINTS; 
DROP TABLE specinst CASCADE CONSTRAINTS; 
DROP TABLE stueth CASCADE CONSTRAINTS;
DROP TABLE specserv CASCADE CONSTRAINTS;
DROP TABLE apprec CASCADE CONSTRAINTS;


/* CREATE STATEMENTS */

--PERSON TABLE

CREATE TABLE per (
	perID 		NUMBER (10),
	perfname 	VARCHAR2 (35) NOT NULL,
	perlname 	VARCHAR2 (35) NOT NULL,
	permname 	VARCHAR2 (35),--NULLABLE BECAUSE SOME MIGHT NOT LIST A MIDDLE NAME. 

CONSTRAINT per_perID_pk PRIMARY KEY(perID));
  
--DEMOGRAPHIC TABLE 
CREATE TABLE dem (
	stuID 		NUMBER (10),
	demgen 		CHAR (1) NOT NULL, 
	demdob  	DATE NOT NULL, 

CONSTRAINT dem_stuID_pk PRIMARY KEY (stuID),
CONSTRAINT dem_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT dem_cc CHECK ((demgen = 'M') OR (demgen = 'F')));

--EMAIL TABLE 

CREATE TABLE email (
	emailID 	NUMBER (10),
	perID 		Number (10),
	emailus 	VARCHAR2 (35) NOT NULL,
	emaildom 	VARCHAR2 (35)NOT NULL,
  
CONSTRAINT email_emailID_pk PRIMARY KEY (emailID, perID),
CONSTRAINT perID_fk FOREIGN KEY (perID) REFERENCES per (perID));

-- ORGANIZATION TABLE 
                                                                
CREATE TABLE org ( 
	orgID 		NUMBER (10), 
	orgname 	VARCHAR2 (35) NOT NULL,
  
CONSTRAINT org_orgID_pk PRIMARY KEY (orgID));

  
--PLACE OF EMPLOYMENT TABLE

CREATE TABLE plofemp (
	perID 		NUMBER (10),
	orgID 		NUMBER (10), 

CONSTRAINT plofemp_pk PRIMARY KEY(perID, orgID),
CONSTRAINT plofemp_perID_fk FOREIGN KEY (perID) REFERENCES per(perID), 
CONSTRAINT plofemp_orgID_fk FOREIGN KEY (orgID) REFERENCES org (orgID));

-- HOSPITAL TABLE 

CREATE TABLE hos (
	stuID 		NUMBER (10),
	orgID 		NUMBER (10),
	hosphn 		NUMBER (10) NOT NULL,  

CONSTRAINT hos_pk PRIMARY KEY (stuID, orgID),  
CONSTRAINT hos_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT hos_orgID_fk FOREIGN KEY (orgID) REFERENCES org (orgID));

-- MEMBERSHIP APPLICATION TABLE

CREATE TABLE stu (
	memID		NUMBER (10),
	stuID 		NUMBER (10),
	orgID 		NUMBER (10), 
	stuyr 		VARCHAR2 (35) NOT NULL, --GRADE IN SCHOOL
	stugradecomm 	VARCHAR2 (35) NOT NULL,
	stugradesatis 	VARCHAR2 (1) NOT NULL, --Y/N
	stuhomewrk 	VARCHAR2 (35) NOT NULL,  
	stuservice 	VARCHAR2 (35) NOT NULL, --Y/N
  
CONSTRAINT stu_pk PRIMARY KEY (memID, stuID, orgID),
CONSTRAINT stu_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT stu_orgID_fk FOREIGN KEY (orgID) REFERENCES org (orgID),
CONSTRAINT stugradesatis_cc CHECK ((stugradesatis = 'Y') OR (stugradesatis = 'N')), 
CONSTRAINT stuservice_cc CHECK ((stuservice = 'Y') OR (stuservice = 'N'))); 


--ETHNICITY TABLE 
                                                            
CREATE TABLE eth( 
  	ethID 		NUMBER (10), 
	ethname		VARCHAR2 (35) NOT NULL, 

CONSTRAINT eth_ethID_pk PRIMARY KEY (ethID)); 


-- STUDENT_ETHNICITY TABLE 

CREATE TABLE stueth ( 
	ethID 		NUMBER (10), 
	stuID 		NUMBER (10), 

CONSTRAINT stueth_pk PRIMARY KEY (ethID, stuID), 
CONSTRAINT stueth_ethID_fk FOREIGN KEY (ethID) REFERENCES eth (ethID), 
CONSTRAINT stueth_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID)); 


-- EMERGENCY CONTACT TABLE

CREATE TABLE emg (
	stuID 		NUMBER (10),
	emgID 		NUMBER (10) NOT NULL,
	relation 	VARCHAR2 (35) NOT NULL,--RELATION TO STUDENT
	emgcall 	CHAR (1) NOT NULL, --CALL IN CASE OF EMERGENCY (Y/N)
	authpick 	CHAR (1) NOT NULL, --AUTHORIZE PICK UP (Y/N)

CONSTRAINT emg_pk PRIMARY KEY(stuID, emgID),
CONSTRAINT emg_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT emg_emgID_fk FOREIGN KEY (emgID) REFERENCES per (perID),
CONSTRAINT emgcall_cc CHECK ((emgcall = 'Y') OR (emgcall = 'N')),
CONSTRAINT authpick_cc CHECK ((authpick = 'Y') OR (authpick = 'N')));
    
-- PHONE TABLE  

CREATE TABLE phn (
	phnID 		NUMBER (10),
	phntype 	VARCHAR2 (1) NOT NULL, -- PRIMARY OR SECONDARY 
	phncntry 	NUMBER (1) NOT NULL,
	phnarea 	NUMBER (3) NOT NULL,
	phnexc 		NUMBER (7) NOT NULL,
	perID 		NUMBER (10) NOT NULL, 

CONSTRAINT phn_phnID_pk PRIMARY KEY(phnID),
CONSTRAINT phn_perID_fk FOREIGN KEY (perID) REFERENCES per (perID),
CONSTRAINT phntype_cc CHECK ((phntype = 'H') OR (phntype = 'C') OR (phntype = 'W')));


-- SPECIAL SERVICES TABLE

CREATE TABLE specserv (
	servID		NUMBER (10),
	specname	VARCHAR2 (35) NOT NULL, 
	
CONSTRAINT specserv_servID_pk PRIMARY KEY (servID));

--STUDENT SPECIAL SERVICES TABLE 

CREATE TABLE stuserv (
	stuID 		NUMBER (10), 
	servID		NUMBER (10),

CONSTRAINT stuserv_pk PRIMARY KEY (stuID, servID), 
CONSTRAINT stuserv_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID), 
CONSTRAINT stuserv_servID_fk FOREIGN KEY (servID) REFERENCES specserv (servID)); 



--INCOME TABLE 

CREATE TABLE inc ( 
	perID NUMBER (10), 
	incfamsi NUMBER (10) NOT NULL, --FAMILY SIZE 
	incinc NUMBER (10) NOT NULL, -- FAMILY INCOME 
	lunch CHAR (1), -- FREE AND REDUCED LUNCH (Y/N) 
	incmili CHAR (1) NOT NULL, --MILITARY STATUS (Y/N) 

CONSTRAINT inc_pk PRIMARY KEY(perID), 
CONSTRAINT inc_perID_fk FOREIGN KEY (perID) REFERENCES per(perID), 
CONSTRAINT lunch_cc CHECK ((lunch = 'Y') OR (lunch = 'N')), 
CONSTRAINT incmili_cc CHECK ((incmili = 'Y') OR (incmili = 'N')));
  
  
--MEDICAL RECORD TABLE

CREATE TABLE medinfo (
	stuID 		NUMBER (10),
	recID		NUMBER (10), 
	medindate 	DATE, -- DATE OF LAST VISIT
	medimupda 	CHAR (1), --IMMUNIZATION UPDATE (Y/N) 
	medcouns  	CHAR (1), --COUNSELING (Y/N)
  
CONSTRAINT medinfo_pk PRIMARY KEY (stuID, recID),  
CONSTRAINT medinfo_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT medimupda_cc CHECK ((medimupda = 'Y') OR (medimupda = 'N')),
CONSTRAINT medcouns_cc CHECK ((medcouns = 'Y') OR (medcouns ='N')));  
  
  
-- ADDRESS TABLE   

CREATE TABLE addr (
	addrID 		NUMBER (10),
	addrstreet 	VARCHAR2 (35) NOT NULL,
	addrcity 	VARCHAR2 (35) NOT NULL, 
	addrst   	CHAR (2) NOT NULL,
	addrzip 	NUMBER (5) NOT NULL,  
  
CONSTRAINT addr_addrID_pk PRIMARY KEY (addrID)); 
 
                                       
--PERSONAL ADDRESS TABLE 

CREATE TABLE peraddr ( 
perID NUMBER (10), 
addrID NUMBER (10), 
addtype CHAR (1) NOT NULL, -- primary or secondary 
	
CONSTRAINT peraddr_pk PRIMARY KEY (perID, addrID), 
CONSTRAINT peraddr_perID_fk FOREIGN KEY (perID) REFERENCES per (perID), 
CONSTRAINT peraddr_addrID_fk FOREIGN KEY (addrID) REFERENCES addr (addrID), 
CONSTRAINT addtype_cc CHECK ((addtype = 'P') OR (addtype = 'S'))); 

--MILITARY BRANCH TABLE
CREATE TABLE brn (
  	milID     NUMBER (10),
	perID 		NUMBER (10),
	brnname 	VARCHAR2(35) NOT NULL,
  
CONSTRAINT brn_perID_pk PRIMARY KEY (milID ,perID), 
CONSTRAINT brn_perID_fk FOREIGN KEY (perID) REFERENCES per (perID)); 
 

--STUDENT DOCTOR TABLE

CREATE TABLE stdoc ( 
stuID NUMBER (10), 
docID NUMBER (10), 
	
CONSTRAINT stdoc_pk PRIMARY KEY (stuID, docID), 
CONSTRAINT stdoc_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID), 
CONSTRAINT stdoc_docID_fk FOREIGN KEY (docID) REFERENCES per (perID)); 
  
--SOCIAL DEVELOPMENT TABLE 

CREATE TABLE socdev (
	socdevID 	NUMBER (10),
	socname 	VARCHAR2 (35) NOT NULL, 

CONSTRAINT socdev_socdevID_pk PRIMARY KEY (socdevID));

--MEMBERSHIP RELEASE FORM TABLE

CREATE TABLE mr (
  relid     NUMBER (10),
	stuID 		NUMBER (10),
	mrdatsig 	DATE NOT NULL,     --DATE SIGNED
	mrliab 		CHAR (1) NOT NULL, --LIABILITY Y/N
	mrtrans 	CHAR (1) NOT NULL, --TRANSPORTATION
	mrpho 		CHAR (1) NOT NULL, --PHOTO/VIDEO Y/N
	mracadem 	CHAR (1) NOT NULL, -- ACADEMIC INFO RELEASE Y/N
	mrcomp 		CHAR (1) NOT NULL, -- COMPUTER USE Y/N   
	mrauthl 	CHAR (1) NOT NULL, -- AUTHORIZED TO LEAVE Y/N
	mrmemsig 	CHAR (1) NOT NULL, -- MEMBER SIGNATURE Y/N
	mrparsig 	CHAR (1) NOT NULL, --PARENT SIGNATURE Y/N
	mrelect 	CHAR (1) NOT NULL, -- ELECTRONICS Y/N
  medindate 	DATE, -- DATE OF LAST VISIT
	medimupda 	CHAR (1), --IMMUNIZATION UPDATE (Y/N) 
	medcouns  	CHAR (1), --COUNSELING (Y/N)
  
  
CONSTRAINT mr_pk PRIMARY KEY (relid, stuID),
CONSTRAINT mr_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT mr_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT mrliab_cc CHECK ((mrliab = 'Y') OR (mrliab = 'N')),  
CONSTRAINT mrtrans_cc CHECK ((mrtrans= 'Y') OR (mrtrans = 'N')),
CONSTRAINT mrpho_cc CHECK ((mrpho = 'Y') OR (mrpho = 'N')),
CONSTRAINT mracadem_cc CHECK ((mracadem = 'Y') OR (mracadem = 'N')),
CONSTRAINT mrcomp_cc CHECK ((mrcomp = 'Y') OR (mrcomp = 'N')),
CONSTRAINT mrauthl_cc CHECK ((mrauthl = 'Y') OR (mrauthl = 'N')), 
CONSTRAINT mrmemsig_cc CHECK ((mrmemsig = 'Y') OR (mrmemsig = 'N')),
CONSTRAINT mrparsig_cc CHECK ((mrparsig = 'Y') OR (mrparsig = 'N')),
CONSTRAINT mrelect_cc CHECK ((mrelect  = 'Y') OR (mrelect  = 'N')),
CONSTRAINT medimupda_cc CHECK ((medimupda = 'Y') OR (medimupda = 'N')),
CONSTRAINT medcouns_cc CHECK ((medcouns = 'Y') OR (medcouns ='N')));


-- Application Record 


CREATE TABLE apprec ( 
	appID 		NUMBER (10), 
	empID 		NUMBER (10), 
	stuID		NUMBER (10), 
	memstat		VARCHAR2 (5) NOT NULL,  --CHECK THIS MEMBER STATUS (GUEST, NEW, RENEW)  
	paymeth		VARCHAR2 (35) NOT NULL, -- PAYMENT METHOD (PAID, CASH, CHECK, MO, SCHOLARSHIP)
	payamou		NUMBER (10) NOT NULL, 
	recdate 	DATE NOT NULL, -- DATE RECEIVED
	entdate 	DATE NOT NULL, -- DATE ENTERED 
 	orida 		DATE NOT NULL, --ORIENTATION DATE
	oriti 		DATE NOT NULL, --ORIENTATION TIME
	oricom 		CHAR (1) NOT NULL, --ORIENTATION COMPLETE (Y/N)

CONSTRAINT apprec_pk PRIMARY KEY (appID), 
CONSTRAINT apprecd_empID_fk FOREIGN KEY (empID) REFERENCES per (perID), 
CONSTRAINT apprec_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID), 
CONSTRAINT memstat_cc CHECK ((memstat = 'Guest') OR (memstat = 'New') OR (memstat = 'Renew')), 
CONSTRAINT oricom_cc CHECK ((oricom = 'Y') OR (oricom = 'N')));

--PROBLEM TABLE

CREATE TABLE pro (
	socdevID	NUMBER (10),
	stuID 		NUMBER (10)  NOT NULL,
	prospec 	VARCHAR2 (35) NOT NULL, 
	probdate 	DATE NOT NULL, 
  
CONSTRAINT pro_pk PRIMARY KEY (socdevID),
CONSTRAINT pro_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT pro_socdevID_fk FOREIGN KEY (socdevID) REFERENCES socdev (socdevID));
                                                                 
                                                                
--ATTENDANCE TABLE 

CREATE TABLE att (
	stuID 		NUMBER (10),
	attdate 	DATE NOT NULL, 
	attchkin 	DATE NOT NULL, 
	attchko 	DATE NOT NULL, 
  
CONSTRAINT att_stuID_pk PRIMARY KEY (stuID),  
CONSTRAINT att_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID)); 


--MEDICATION TABLE

CREATE TABLE med (
	medID 		NUMBER (10),
	medname		VARCHAR (35), 
	hosname VARCHAR2 (10)NOT NULL, --name
	medamt NUMBER (10) NOT NULL, --amount 
	meddir VARCHAR2 (35) NOT NULL, --HOW TO TAKE (MOUTH, EYE DROPS, EAR, ON SKIN, ETC)
	medti DATE NOT NULL, -- TIME/S OF DAY
	medre VARCHAR2 (35) NOT NULL, -- REASON
  
CONSTRAINT med_medID_pk PRIMARY KEY (medID)); 

--MEDICAL CONDITION TABLE
CREATE TABLE medcond (
  conID NUMBER (10),
  stuID NUMBER (10),
  connm VARCHAR2 (35),
  
CONSTRAINT medcond_pk PRIMARY KEY (conID, stuID),
CONSTRAINT medcond_fk FOREIGN KEY (stuID) REFERENCES per (perID));

--SPECIAL INSTRUCTIONS TABLE

CREATE TABLE specinst (
	stuID 		NUMBER (10),
	medID 		NUMBER (10),
	meddesc 	VARCHAR (35) NOT NULL, 
	medamt 		NUMBER (10) NOT NULL,   --amount 
	meddir 		VARCHAR2 (35) DEFAULT 'None' NOT NULL, 
 	medti 		DATE NOT NULL,  -- TIME/S OF DAY
	medre 		VARCHAR2 (35) NOT NULL,   -- REASON
 
CONSTRAINT specinst_pk PRIMARY KEY (stuID, medID),  
CONSTRAINT specinst_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID),
CONSTRAINT specinst_medID_fk FOREIGN KEY (medID) REFERENCES med (medID));

 -- PARENT/GUARDIAN CONSENT FORM TABLE 
                                                            
CREATE TABLE parguar ( 
   	stuID 		NUMBER (10), 
   	sign  		VARCHAR2 (35) NOT NULL, --Parent/Guardian signature (Y/N)
   	parID 		NUMBER (10) NOT NULL, 
   
CONSTRAINT parguar_stuID_pk PRIMARY KEY (stuID), 
CONSTRAINT parguar_stuID_fk FOREIGN KEY (stuID) REFERENCES per (perID), 
CONSTRAINT parguar_parID_fk FOREIGN KEY (parID) REFERENCES per (perID),
CONSTRAINT sign_cc CHECK ((sign = 'Y') OR (sign = 'N')));

					   
					   
--INSERT STATEMENTS
--PERSON
INSERT INTO per
  VALUES (1000, 'Noah', 'Wetzel','James');
  
INSERT INTO per
  VALUES (1001, 'Jordan', 'Jansen','Fredrick'); 
  
INSERT INTO per
  VALUES (1002, 'Ian', 'Wetzel','Charles');
  
INSERT INTO per
  VALUES (1003, 'Justin', 'Lorentz','Allen');  
  
INSERT INTO per
  VALUES (1004, 'Rachel', 'Stout','Marie');
  
INSERT INTO per
  VALUES (1005, 'Erin', 'Wetzel','Charlene');

INSERT INTO per
  VALUES (1006, 'Sunny', '', 'Chen');
  
INSERT INTO per
  VALUES (1007, 'Jacob', 'Maurer','Peter');

INSERT INTO per
  VALUES (1008, 'Yong Sheng', '', 'Lai');

INSERT INTO per
  VALUES (1009, 'Mark', 'Smith', 'Brewer');

INSERT INTO per
  VALUES (1010, 'Sarah', 'Adam', 'Lee');

INSERT INTO per
  VALUES (1011, 'William', 'Salmon', 'Smith');  

INSERT INTO per
  VALUES (1012, 'John', 'Alex', 'Denner'); 

INSERT INTO per
  VALUES (2001, 'Sam', 'Kaur', 'Perdeep');
  
INSERT INTO per
  VALUES (2002, 'Hunter', 'Rose', 'Bronco');
  
INSERT INTO per
  VALUES (2003, 'Adam', 'Ghosh', 'Clark');

INSERT INTO per
  VALUES (2004, 'Klein', 'Quinn', 'Lopez');
  
INSERT INTO per
  VALUES (2005, 'Alex', 'Smith', 'Clark');

INSERT INTO per
  VALUES (2006, 'Joyce', '', 'Reily');
  
INSERT INTO per
  VALUES (3001, 'Timmy', 'Mufasa', 'Rafiki');
  
INSERT INTO per
  VALUES (3002, 'James', 'William', 'David');
  
INSERT INTO per
  VALUES (3003, 'Johnson', 'Maria', 'David');
  
INSERT INTO per
  VALUES (3004, 'Taylor', '', 'Swift');
  
INSERT INTO per
  VALUES (3005, 'Clark', '', 'Lee');

INSERT INTO per
  VALUES (3006, 'Samuel', 'Charles', 'David');
  
INSERT INTO per
  VALUES (4001, 'Mary', '', 'Elizabeth');
  
INSERT INTO per
  VALUES (4002, 'Nancy', 'Catherine', 'Ann');

INSERT INTO per
  VALUES (4003, 'Thomas', 'Joseph', 'Yellow');

INSERT INTO per
  VALUES (4004, 'Daniel', 'Samuel', 'Williams');
  
INSERT INTO per
  VALUES (4005, 'James', '', 'George');
  
INSERT INTO per
  VALUES (4006, 'Henry', 'Charles', 'Lee');
  
SELECT * FROM pers;

--DEMOGRAPHIC 
--Inserts 
INSERT INTO dem 
	VALUES (2001, 'F', TO_DATE('10/20/2008', 'MM/DD/YYYY')); 
INSERT INTO dem 
	VALUES (2002, 'M', TO_DATE('12/25/2009', 'MM/DD/YYYY')); 
INSERT INTO dem 
	VALUES (2003, 'M', TO_DATE('05/11/2008', 'MM/DD/YYYY')); 
INSERT INTO dem 
	VALUES (2004, 'M', TO_DATE('08/18/2008', 'MM/DD/YYYY')); 
INSERT INTO dem 
	VALUES (2005, 'M', TO_DATE('07/20/2009', 'MM/DD/YYYY')); 
INSERT INTO dem 
	VALUES (2006, 'F', TO_DATE('01/05/2010', 'MM/DD/YYYY')); 
  
SELECT * FROM dem  
  
--EMAIL  
INSERT INTO email 
	VALUES (001, 2001, 'sam5708', 'uwec.edu'); 
INSERT INTO email 
	VALUES (002, 2002, 'bronco3400', 'uwec.edu'); 
INSERT INTO email 
	VALUES (003, 2003, 'clark1123', 'gmail.com'); 
INSERT INTO email 
	VALUES (004, 2004, 'LORENTJA6352', 'uwec.edu'); 
INSERT INTO email 
	VALUES (005, 2005, 'ghosh2345', 'uwec.edu' ); 
INSERT INTO email 
	VALUES (006, 2006, 'reilyj0915', 'gmail.com');
  
SELECT * FROM email;
  
--PHONE DO WE NEED TO ADD PERSON ID?? 
INSERT INTO phn 
	VALUES (10001, 'C', 1, 920, 8583994, 1000); --Fix data type in create table 
INSERT INTO phn 
	VALUES (10002, 'C', 1, 715, 7652134, 1001); 
INSERT INTO phn 
	VALUES (10003, 'C', 1, 920, 4562177, 1002); 
INSERT INTO phn 
	VALUES (10004, 'W', 1, 414, 8865432, 1003); 
INSERT INTO phn 
	VALUES (10005, 'C', 1, 952, 7775544, 1004); 
INSERT INTO phn 
	VALUES (10006, 'W', 1, 920, 3435612, 1005); 
INSERT INTO phn 
	VALUES (10007, 'C', 1, 920, 8583994, 1006); 
INSERT INTO phn 
	VALUES (10008, 'C', 1, 715, 7785656, 1007); 
INSERT INTO phn 
	VALUES (10009, 'C', 1, 715, 5593210, 1008); 
INSERT INTO phn 
	VALUES (10010, 'C', 1, 715, 5593845, 1009); 
INSERT INTO phn 
	VALUES (10011, 'C', 1, 715, 5598765, 1010); 
INSERT INTO phn 
	VALUES (10012, 'C', 1, 715, 5658811, 1011); 
INSERT INTO phn 
	VALUES (10013, 'C', 1, 715, 5593472, 1012); 
INSERT INTO phn 
	VALUES (10014, 'W', 1, 715, 5598734, 1007); 
INSERT INTO phn 
	VALUES (10015, 'W', 1, 715, 5593344, 1008); 
INSERT INTO phn 
	VALUES (10016, 'W', 1, 715, 5598787, 1009); 
INSERT INTO phn 
	VALUES (10012, 'W', 1, 715, 5653239, 1011); 
INSERT INTO phn 
	VALUES (10013, 'W', 1, 715, 4549090, 3001); 
INSERT INTO phn 
	VALUES (10014, 'W', 1, 715, 8884427, 3002); 
INSERT INTO phn 
	VALUES (10015, 'W', 1, 715, 5552194, 1008); 
INSERT INTO phn 
	VALUES (10016, 'W', 1, 715, 5598787, 1009); 
INSERT INTO phn 
	VALUES (10017, 'W', 1, 715, 5653239, 1011); 
INSERT INTO phn 
	VALUES (10018, 'W', 1, 715, 4549090, 3001); 
INSERT INTO phn 
	VALUES (10019, 'W', 1, 715, 8884427, 3002); 
INSERT INTO phn 
	VALUES (10020, 'W', 1, 715, 1116547, 3003); 
INSERT INTO phn 
	VALUES (10021, 'W', 1, 715, 0021757, 3004); 
INSERT INTO phn 
	VALUES (10022, 'W', 1, 715, 8185957, 3005); 
INSERT INTO phn 
	VALUES (10023, 'W', 1, 715, 5623897, 3006); 
INSERT INTO phn 
	VALUES (10020, 'W', 1, 715, 1116547, 3003); 
INSERT INTO phn 
	VALUES (10021, 'W', 1, 715, 0021757, 3004); 
INSERT INTO phn 
	VALUES (10022, 'W', 1, 715, 8185957, 3005); 
INSERT INTO phn 
	VALUES (10023, 'W', 1, 715, 5623897, 3006);
  
  SELECT * FROM phn
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
   
SELECT * FROM addr
  
--STUDENT (stuID,stuorgID, student year inschool jun sen, student lunch y/n, student retained, stu grade comments, stu grades sat?, stu homework,stuservID)
INSERT INTO stu
  VALUES (101, 2001, 1011,  'Junior', 'Excellent', 'Y', 'Math', 'N');

INSERT INTO stu
  VALUES (102, 2002, 1012,  'Freshman', 'Average', 'N', 'Sciences', 'N');

INSERT INTO stu
  VALUES (103, 2003, 1013,  'Sophmore', 'Okay', 'Y', 'Social Studies', 'N');

INSERT INTO stu
  VALUES (104, 2004, 1014, 'Senior', 'Okay', 'N', 'Sciences ', 'Y');

INSERT INTO stu
  VALUES (105, 2005, 1015, 'Freshman', 'Average', 'N', 'Math', 'Y');

INSERT INTO stu
  VALUES (106, 2006, 1011, 'Freshman', 'Excellent', 'Y', 'Math', 'N');

SELECT * FROM stu;	

--INSERT EMERGENCY CONTACT

INSERT INTO emg
	VALUES (1000, 2000, 'Father', 'Y', 'Y');

INSERT INTO emg
	VALUES (1001, 2001, 'Brother', 'N', 'Y');

INSERT INTO emg
	VALUES (1002, 2002, 'Father', 'Y', 'N');

INSERT INTO emg
	VALUES (1003, 2003, 'Brother', 'Y', 'Y');

INSERT INTO emg
	VALUES (1004, 2004, 'Mother', 'Y', 'N');

INSERT INTO emg
	VALUES (1005, 2005, 'Sister', 'N', 'N');

INSERT INTO emg
	VALUES (1006, 2006, 'Mother', 'Y', 'Y');
	
INSERT INTO emg
	VALUES (1007, 2001, 'Brother', 'Y', 'Y');
  
INSERT INTO emg
	VALUES (1008, 2002, 'Cousin', 'Y', 'N');
  
INSERT INTO emg
	VALUES (1009, 2003, 'Brother', 'Y', 'N');

INSERT INTO emg
	VALUES (1010, 2004, 'Sister', 'Y', 'N');
  
INSERT INTO emg
	VALUES (1011, 2005, 'Brother', 'Y', 'N');
  
INSERT INTO emg
	VALUES (1012, 2006, 'Father', 'Y', 'N');

SELECT * FROM emg

--Insert Statements for Income Table /* Insert statements for Income. */ 
INSERT INTO inc 
	VALUES ( 2001,4, 69000, 'Y', 'N'); 
INSERT INTO inc 
	VALUES ( 2002,6, 240000, 'N', 'N'); 
INSERT INTO inc 
	VALUES ( 2003,2, 100000, 'N', 'N'); 
INSERT INTO inc 
	VALUES ( 2004,3, 120000, 'N', 'Y'); 
INSERT INTO inc 
	VALUES ( 2005,2, 30000, 'Y', 'Y'); 
INSERT INTO inc 
	VALUES ( 2006,5, 150000, 'N', 'Y'); 

SELECT * FROM inc;

--ATTENDANCE TABLE (2001, attendance date, check in date, check out date)
INSERT INTO att	
	VALUES (2001, TO_DATE(('02-02-2018'), 'MM/DD/YYYY'), TO_DATE(('16:00'), 'HH24:MI'), TO_DATE(('18:00'),'HH24:MI'));
	
INSERT INTO att	
	VALUES (2002, TO_DATE(('02-13-2018'), 'MM/DD/YYYY'), TO_DATE(('16:00'), 'HH24:MI'), TO_DATE(('18:00'),'HH24:MI'));	

INSERT INTO att	
	VALUES (2003, TO_DATE(('03-02-2018'), 'MM/DD/YYYY'), TO_DATE(('17:00'), 'HH24:MI'), TO_DATE(('19:00'),'HH24:MI'));
	
INSERT INTO att	
	VALUES (2004, TO_DATE(('04-22-2018'), 'MM/DD/YYYY'), TO_DATE(('16:00'), 'HH24:MI'), TO_DATE(('18:00'),'HH24:MI'));	
	
INSERT INTO att	
	VALUES (2005, TO_DATE(('05-02-2018'), 'MM/DD/YYYY'), TO_DATE(('14:00'), 'HH24:MI'), TO_DATE(('16:00'),'HH24:MI'));
	
INSERT INTO att	
	VALUES (2006, TO_DATE(('04-12-2018'), 'MM/DD/YYYY'), TO_DATE(('16:00'), 'HH24:MI'), TO_DATE(('18:00'),'HH24:MI'));						   

SELECT * FROM att;  

/* Script to populate the organization table */

INSERT INTO org 
	VALUES (1001, 'Mason Companies, Inc');

INSERT INTO org 
	VALUES (1002, 'Landmark Company');

INSERT INTO org 
	VALUES (1003, 'Securian Financial Group');

INSERT INTO org 
	VALUES (1004, 'Chippewa Valley Hospital');

INSERT INTO org 
	VALUES (1005, 'Menards');

INSERT INTO org 
	VALUES (1006, 'Target Corporation');

INSERT INTO org 
	VALUES (1007, 'Curt Manufacturing LLC');

INSERT INTO org 
	VALUES (1008, 'Mayo Clinic Health System');

INSERT INTO org 
	VALUES (1009, 'Sacred Heart Hospital');

INSERT INTO org 
	VALUES (1010, 'HSHS St. Joseph''s Hospital');
	
INSERT INTO org 
	VALUES (1011, 'Memorial High School');

INSERT INTO org 
	VALUES (1012, 'Manz Elementary School'); 

INSERT INTO org 
	VALUES (1013, 'Flynn Elementary School');

INSERT INTO org
	VALUES (1014, 'Southview Elementary School');

INSERT INTO org 
	VALUES (1015, 'Parkview Elementary School'); 	

SELECT * FROM org;	

/* Script to populate place of employment table */ 

INSERT INTO plofemp 
	VALUES (1001, 1001); 

INSERT INTO plofemp 
	VALUES (1000, 1002); 

INSERT INTO plofemp 
	VALUES (1003, 1003); 

INSERT INTO plofemp 
	VALUES (1008, 1003); 

INSERT INTO plofemp 
	VALUES (1009, 1003); 

INSERT INTO plofemp 
	VALUES (1004, 1004); 

INSERT INTO plofemp 
	VALUES (3001, 1004); 

INSERT INTO plofemp 
	VALUES (1005, 1005); 

INSERT INTO plofemp 
	VALUES (1006, 1006); 

INSERT INTO plofemp 
	VALUES (1007, 1007); 

INSERT INTO plofemp 
	VALUES (3002, 1008); 

INSERT INTO plofemp 
	VALUES (3003, 1009); 

INSERT INTO plofemp 
	VALUES (1010, 1009); 

INSERT INTO plofemp 
	VALUES (1011, 1009); 

INSERT INTO plofemp 
	VALUES (1012, 1009); 

INSERT INTO plofemp 
	VALUES (3004, 1009); 

INSERT INTO plofemp 
	VALUES (3005, 1010);
		
SELECT * FROM plofemp;

--Script to populate the Hospital table

INSERT INTO hos 
	VALUES (2001, 1004, 7156724211);

INSERT INTO hos 
	VALUES (2002, 1004,7156724211);

INSERT INTO hos 
	VALUES (2003, 1008, 7158385222);

INSERT INTO hos 
	VALUES (2004, 1009, 7157174121);

INSERT INTO hos 
	VALUES (2005, 1010, 7157231811);

INSERT INTO hos 
	VALUES (2006, 1009, 7157174121);

INSERT INTO hos 
	VALUES (2001, 1008, 7158385222); 
	
INSERT INTO hos 
	VALUES (2002, 1010, 7157231811);

SELECT * FROM hos;

/* Script to populate Special Services Table */ 

INSERT INTO specserv 
	VALUES (2100, 'Speech');

INSERT INTO specserv 
	VALUES (2101, 'English Language Learner');

INSERT INTO specserv 
	VALUES (2102, 'Title I');

INSERT INTO specserv 
	VALUES (2103, 'Cognitive disability');

INSERT INTO specserv 
	VALUES (2104, 'Learning Disability');

INSERT INTO specserv 
	VALUES (2105, 'Emotional/behavioral disability');

SELECT * FROM specserv;

/* Script to populate Student Special Services Table */

INSERT INTO stuserv 
	VALUES (2002, 2100); 

INSERT INTO stuserv 
	VALUES (2003, 2101); 

INSERT INTO stuserv 
	VALUES (2002, 2104); 

INSERT INTO stuserv 
	VALUES (2003, 2102); 

INSERT INTO stuserv 
	VALUES (2002, 2103); 

INSERT INTO stuserv 
	VALUES (2002, 2105); 

INSERT INTO stuserv 
	VALUES (2006, 2104); 

INSERT INTO stuserv 
	VALUES (2006, 2102); 

INSERT INTO stuserv 
	VALUES (2001, 2102); 

SELECT * FROM stuserv;	

------------Inserts for peraddr table 
INSERT INTO peraddr 
	VALUES (2001, 5002, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2001, 5011, 'S'); 
	
INSERT INTO peraddr
	VALUES (2002, 5003, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2002, 5012, 'S'); 
	
INSERT INTO peraddr 
	VALUES (2003, 5004, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2003, 5013, 'S'); 
	
INSERT INTO peraddr 
	VALUES (2004, 5005, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2004, 5014, 'S'); 
	
INSERT INTO peraddr 
	VALUES (2005, 5005, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2005, 5015, 'S'); 
	
INSERT INTO peraddr 
	VALUES (2006, 5006, 'P'); 
	
INSERT INTO peraddr 
	VALUES (2006, 5016, 'S'); 
	
SELECT * FROM peraddr;

---Inserts for Student Doctor Table 
INSERT INTO studoc
	VALUES (2001, 3001); 
INSERT INTO studoc 
	VALUES (2002, 3002); 
INSERT INTO studoc 
	VALUES (2003, 3003); 
INSERT INTO studoc 
	VALUES (2004, 3004); 
INSERT INTO studoc 
	VALUES (2005, 3005); 
INSERT INTO studoc 
	VALUES (2006, 3006); 
	
SELECT * FROM studoc;	

--"?" means perID

--Insert statements for Military Branch table
INSERT INTO brn
	VALUES(001,2004, 'Navy');

INSERT INTO brn
	VALUES(002,2004, 'Air Force');

INSERT INTO brn
	VALUES(003,2005, 'Coast Guard');

INSERT INTO brn
	VALUES(004,2006, 'Army');

INSERT INTO brn
	VALUES(005,2006, 'Marine Corps');

INSERT INTO brn
	VALUES(006,2005, 'Air Force');

--INSERT statements for Ethnicity table

INSERT INTO eth
	VALUES(1239808547, 'Asian');

INSERT INTO eth
	VALUES(3940219345, 'Native American');

INSERT INTO eth
	VALUES(8392019403, 'Black');

INSERT INTO eth
	VALUES(1890345438, 'White');

INSERT INTO eth
	VALUES(6294014931, 'Pacific Islander');


--Insert statements for Parent/Guardian Consent table
INSERT INTO parguar
	VALUES(2001, Yes, 1000);

INSERT INTO parguar
	VALUES(2002, Yes, 1001);

INSERT INTO parguar
	VALUES(2003, Yes, 1002);

INSERT INTO parguar
	VALUES(2004, Yes, 1003);

INSERT INTO parguar
	VALUES(2005, No, 1004);

INSERT INTO parguar
	VALUES(2006, Yes, 1005);

--Insert statements for Special Instructions table
INSERT INTO specinst
	VALUES(2001, 1400204019, 'Celexa', 2, 'Take 2 pills by mouth', TO_DATE('16:45', 'HH24:MI'), 'Depression');

INSERT INTO specinst
	VALUES(2001, 1230989048, 'Xanax',  3, 'Take 3 pills by mouth', TO_DATE('10:00', 'HH24:MI'), 'Anxiety');

INSERT INTO specinst
	VALUES(2002, 3593049013, 'Flovent', 2, 'Inhale two puffs', TO_DATE('14:00', 'HH24:MI'), 'Asthma');

INSERT INTO specinst
	VALUES(2002, 5010584920, 'Humulin', 1, 'Inject one amount', TO_DATE('12:00', 'HH24:MI'), 'Diabetes');

INSERT INTO specinst
	VALUES(2003, 8923498981, 'Oflaxin', 3, 'Put two drops into ear', TO_DATE('9:00', 'HH24:MI'), 'Ear Infection');

INSERT INTO specinst
	VALUES(2003, 2406920194, 'Aldactone', 2, 'Take 2 pills by mouth', TO_DATE('15:00', 'HH24:MI'), 'Heart Disease');
									       
SELECT * FROM specinst;	
									       
--Insert statements for Medications table
INSERT INTO med
	VALUES(1400204019, 'Celexa');

INSERT INTO med
	VALUES(1230989048, 'Xanax');

INSERT INTO med
	VALUES(3593049013, 'Flovent');

INSERT INTO med
	VALUES(5010584920, 'Humulin');

INSERT INTO med
	VALUES(8923498981, 'Oflaxin');

INSERT INTO med
	VALUES(2406920194, 'Aldactone');

SELECT * FROM med;	
--Insert statement for Student Ethnicity table
INSERT INTO stueth
	VALUES(1890345438, 2001);

INSERT INTO stueth
	VALUES(1890345438, 2002);

INSERT INTO stueth
	VALUES(1890345438, 2003);

INSERT INTO stueth
	VALUES(1890345438, 2004);

INSERT INTO stueth
	VALUES(3940219345, 2005);

INSERT INTO stueth
	VALUES(6294014931, 2001);

INSERT INTO stueth
	VALUES(1239808547, 2002);

INSERT INTO stueth
	VALUES(8392019403, 2003);

SELECT * FROM stueth;	  
	       
INSERT INTO apprec
  VALUES (6701, 4001, 2001, 'Guest', 'Paid', 1500, TO_DATE('2/10/2018','MM/DD/YYYY'), TO_DATE('2/12/2018','MM/DD/YYYY'), TO_DATE('3/05/2018','MM/DD/YYYY'),TO_DATE('08:00','HH24:MI'), 'Y');
  
INSERT INTO apprec
  VALUES (6702, 4002, 2002, 'New', 'Cash', 4000, TO_DATE('1/01/2018','MM/DD/YYYY'), TO_DATE('1/03/2018','MM/DD/YYYY'), TO_DATE('2/01/2018','MM/DD/YYYY'),TO_DATE('09:00','HH24:MI'), 'N');

INSERT INTO apprec
  VALUES (6703, 4003, 2002, 'Renew', 'Check', 7500, TO_DATE('3/15/2018','MM/DD/YYYY'), TO_DATE('3/18/2018','MM/DD/YYYY'), TO_DATE('3/15/2018','MM/DD/YYYY'),TO_DATE('08:30','HH24:MI'), 'Y');

INSERT INTO apprec
  VALUES (6704, 4004, 2003, 'Guest', 'Paid', 590, TO_DATE('1/03/2018','MM/DD/YYYY'), TO_DATE('1/10/2018','MM/DD/YYYY'), TO_DATE('2/07/2018','MM/DD/YYYY'),TO_DATE('09:45','HH24:MI'), 'N');

INSERT INTO apprec
  VALUES (6705, 4005, 2004, 'Renew', 'Scholarship', 6000, TO_DATE('4/18/2018','MM/DD/YYYY'), TO_DATE('4/24/2018','MM/DD/YYYY'), TO_DATE('5/04/2018','MM/DD/YYYY'),TO_DATE('10:00','HH24:MI'), 'Y');

INSERT INTO apprec
  VALUES (6706, 4006, 2005, 'New', 'Cash', 350, TO_DATE('2/23/2018','MM/DD/YYYY'), TO_DATE('2/24/2018','MM/DD/YYYY'), TO_DATE('3/01/2018','MM/DD/YYYY'),TO_DATE('09:15','HH24:MI'), 'N');
  
  INSERT INTO mr 
  VALUES (2001, TO_DATE('1/04/2018','MM/DD/YYYY'), 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y','Y','Y');

INSERT INTO mr 
  VALUES (2002, TO_DATE('2/06/2018','MM/DD/YYYY'), 'Y', 'N', 'Y', 'Y', 'Y', 'Y', 'Y','N','N');

INSERT INTO mr 
  VALUES (2003, TO_DATE('1/17/2018','MM/DD/YYYY'), 'N', 'Y', 'Y', 'N', 'Y', 'Y', 'N','Y','Y');
  
INSERT INTO mr 
  VALUES (2004, TO_DATE('2/18/2018','MM/DD/YYYY'), 'Y', 'Y', 'N', 'Y', 'N', 'Y', 'Y','Y','Y');
  
INSERT INTO mr 
  VALUES (2005, TO_DATE('3/10/2018','MM/DD/YYYY'), 'N', 'Y', 'Y', 'Y', 'Y', 'N', 'Y','N','Y');

INSERT INTO mr 
  VALUES (2006, TO_DATE('3/20/2018','MM/DD/YYYY'), 'Y', 'Y', 'N', 'N', 'N', 'N', 'Y','Y','Y');
  
--INSERT SOCIAL DEVELOPMENT TABLE
--Q: SOCIAL DEVELOPMENT NAME MEANS??
INSERT INTO socdev
  VALUES (52001, 'Improving');

INSERT INTO socdev
  VALUES (52002, 'Not Improving');

INSERT INTO socdev
  VALUES (52003, 'Improving');
  
INSERT INTO socdev
  VALUES (52004, 'Improving');
  
INSERT INTO socdev
  VALUES (52005, 'Improving');
  
INSERT INTO socdev
  VALUES (52006, 'Not Improving');
  
 --INSERT PROBLEM TABLE
 --Q: PROBLEM SPECIFICATIONS??
 INSERT INTO pro
  VALUES (52001, 2001, 'Missing classes', TO_DATE('1/05/2018','MM/DD/YYYY'));

 INSERT INTO pro
  VALUES (52002, 2002, 'Teen pregnancy', TO_DATE('2/11/2018','MM/DD/YYYY'));
  
 INSERT INTO pro
  VALUES (52003, 2003, 'Drug abuse', TO_DATE('1/24/2018','MM/DD/YYYY'));

 INSERT INTO pro
  VALUES (52004, 2004, 'Bullying classmates', TO_DATE('2/05/2018','MM/DD/YYYY'));
  
 INSERT INTO pro
  VALUES (52005, 2005, 'Violent behaviors', TO_DATE('3/13/2018','MM/DD/YYYY'));
  
 INSERT INTO pro
  VALUES (52006, 2006, 'Racist slurs', TO_DATE('4/18/2018','MM/DD/YYYY'));
  
--Medical Condition

INSERT INTO medcond
  VALUES (431, 2001, 'Anxiety');

INSERT INTO medcond
  VALUES (432, 2001, 'Depression');
  
INSERT INTO medcond
  VALUES (433, 2002, 'Asthma');

INSERT INTO medcond
  VALUES (434, 2002, 'Diabetes');
  
INSERT INTO medcond
  VALUES (435, 2003, 'Ear infection');
  
INSERT INTO medcond
  VALUES (436, 2003, 'Heart diesease');


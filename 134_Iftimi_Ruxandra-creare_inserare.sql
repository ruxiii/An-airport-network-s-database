--CREARE--
create table AEROPORT(
    ID_AEROPORT int not null primary key,
    NUME_AEROPORT varchar2(50),
    LOCATIE_AEROPORT varchar2(50),
    NUMAR_ZBORURI_AN int,
    NUMAR_CALATORI_AN long
);

--drop table AEROPORT;

create table DEPARTAMENTE(
    ID_DEPARTAMENT int not null primary key,
    NUME_DEPARTAMENT varchar2(30),
    NUMAR_ANGAJATI int,
    ID_AEROPORT not null,
    foreign key (ID_AEROPORT) references AEROPORT(ID_AEROPORT)
);

--drop table DEPARTAMENTE;

create table ANGAJATI(
    ID_ANGAJAT int not null primary key,
    NUME_ANGAJAT varchar2(20),
    DATA_ANGAJARII varchar2(30),
    SALARIU_ANGAJATI int,
    ID_DEPARTAMENT not null,
    foreign key(ID_DEPARTAMENT) references DEPARTAMENTE(ID_DEPARTAMENT)
);

--drop table ANGAJATI;

create table TURN_CONTROL(
    ID_TURN_CONTROL int not null primary key,
    NUMAR_AERONAVE_COORDONATE long,
    NUMAR_CONTROLORI_TRAFIC int,
    ID_AEROPORT not null,
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT)
);

--drop table TURN_CONTROL;

create table COMPANII_AERIENE(
    ID_COMPANIE int not null primary key,
    NUME_COMPANIE varchar2(50),
    NUMAR_AVION_COMPANIE long,
    ORAS_SEDIU varchar2(30),
    ID_AEROPORT not null,
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT)
);

--drop table COMPANII_AERIENE;

create table AVIOANE(
    ID_AVION int not null primary key,
    TIP_AVION varchar2(20),
    ID_COMPANIE not null,
    foreign key(ID_COMPANIE) references COMPANII_AERIENE(ID_COMPANIE)
);

--drop table AVIOANE;

create table ZBORURI(
    ID_ZBOR int not null primary key,
    DESTINATIE_ZBOR varchar2(30),
    DURATA_CALATORIEI_IN_ORE int,
    ID_AEROPORT not null,
    ID_COMPANIE not null,
    foreign key(ID_COMPANIE) references COMPANII_AERIENE(ID_COMPANIE),
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT)
);

--drop table ZBORURI;

create table PERSONAL(
    ID_PERSONAL int not null primary key,
    NUME_PERSONAL varchar2(20),
    DEPARTAMENT_PERSONAL varchar2(20),
    SALARIU_PERSONAL int,
    ID_COMPANIE not null,
    foreign key(ID_COMPANIE) references COMPANII_AERIENE(ID_COMPANIE)
);

--drop table PERSONAL;

create table PERSONAL_ORGANIZATORIC (
    ID_PERSONAL_ORGANIZATORIC int not null primary key,
    NUMAR_ORE_LUCRATE int,
    FUNCTIE_ORGANIZATORIC varchar2(20),
    DEPARTAMENT_ORGANIZATORIC varchar2(20),
    ID_PERSONAL not null,
    foreign key(ID_PERSONAL) references PERSONAL(ID_PERSONAL)
);

--drop table PERSONAL_ORGANIZATORIC;

create table PERSONAL_ZBOR (
    ID_PERSONAL_ZBOR int not null primary key,
    CATEGORIE_PERSONAL_ZBOR varchar2(20),
    NUMAR_ZBORURI_ACTIV int,
    ORE_EXPERIENTA int,
    ID_PERSONAL not null,
    foreign key(ID_PERSONAL) references PERSONAL(ID_PERSONAL)
);

--drop table PERSONAL_ZBOR;

create table PASAGERI (
    ID_PASAGER int not null primary key,
    NUME_PASAGER varchar2(20),
    NATIONALITATE varchar2(30),
    TARA_DE_PROVENIENTA varchar2(30),
    ID_AEROPORT not null,
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT)
);

--drop table PASAGERI;

create table BILETE (
    ID_BILET int not null primary key,
    OPERATOR_BILET varchar2(50),
    PRET int,
    ID_PASAGER not null,
    foreign key(ID_PASAGER) references PASAGERI(ID_PASAGER)
);

--drop table BILETE;

create table BAGAJE (
    ID_BAGAJ int not null primary key,
    DESTINATIE_FINALA_BAGAJ varchar2(30),
    ID_AEROPORT not null,
    ID_PASAGER not null,
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT),
    foreign key(ID_PASAGER) references PASAGERI(ID_PASAGER)
);

--drop table BAGAJE;

create table DESTINATIE (
    ID_DESTINATIE int not null primary key,
    ORA_SOSIRII int,
    ID_AEROPORT not null,
    ID_PASAGER not null,
    foreign key(ID_AEROPORT) references AEROPORT(ID_AEROPORT),
    foreign key(ID_PASAGER) references PASAGERI(ID_PASAGER)
);

--drop table DESTINATIE;

create table ESTE_TRANZITAT (
    ID_PASAGER int not null, 
    ID_AEROPORT int not null,
    constraint pk_este_tranzitat primary key(ID_PASAGER, ID_AEROPORT)
);

-- drop table ESTE_TRANZITAT;

create table AJUNG (
    ID_PASAGER int not null, 
    ID_AEROPORT int not null,
    ID_BAGAJ int not null,
    constraint pk_ajung primary key(ID_PASAGER, ID_AEROPORT, ID_BAGAJ)
);

--drop table AJUNG;




--INSERARE--
insert into AEROPORT values (1000, 'Henri Coanda', 'Bucuresti', 500, 20000);
insert into AEROPORT values (1100, 'Schipol', 'Amsterdam', 1000, 100500);
insert into AEROPORT values (1200, 'Heathrow', 'Londra', 1500, 300000);
insert into AEROPORT values (1300, 'Charles de Gaulle', 'Paris', 1100, 100000);
insert into AEROPORT values (1400, 'John F. Kennedy', 'New York', 2000, 900000);
insert into AEROPORT values (1500, 'Beijing', 'Beijing', 3000, 1000000);

select * from AEROPORT;

insert into DEPARTAMENTE values (1001, 'HR' ,100, 1000);
insert into DEPARTAMENTE values (1002, 'PR' ,100, 1000);
insert into DEPARTAMENTE values (1003, 'Logistica', 50, 1100);
insert into DEPARTAMENTE values (1004, 'Comercial', 40, 1100);
insert into DEPARTAMENTE values (1005, 'Marketing', 25, 1200);
insert into DEPARTAMENTE values (1006, 'Control', 10, 1200);
insert into DEPARTAMENTE values (1007, 'Securitate', 5, 1300);
insert into DEPARTAMENTE values (1008, 'Operatiuni', 80, 1300);
insert into DEPARTAMENTE values (1009, 'Management', 45, 1400);
insert into DEPARTAMENTE values (1010, 'Achizitii', 30, 1400);
insert into DEPARTAMENTE values (1011, 'Finante', 100, 1500);
insert into DEPARTAMENTE values (1012, 'Dezvoltare', 30, 1500);
insert into DEPARTAMENTE values (1013, 'Director_1000', 5, 1000);
insert into DEPARTAMENTE values (1014, 'Director_1100', 80, 1100);
insert into DEPARTAMENTE values (1015, 'Director_1200', 45, 1200);
insert into DEPARTAMENTE values (1016, 'Director_1300', 30, 1300);
insert into DEPARTAMENTE values (1017, 'Director_1400', 100, 1400);
insert into DEPARTAMENTE values (1018, 'Director_1500', 30, 1500);

select * from DEPARTAMENTE;

insert into ANGAJATI values (111, 'Popescu', '21-03-2010', 2000, 1001);
insert into ANGAJATI values (112, 'Marinescu', '18-09-2009', 5000, 1002);
insert into ANGAJATI values (113, 'Popa', '20-05-2011', 4500, 1003);
insert into ANGAJATI values (114, 'Spataru', '03-03-2010', 6300, 1004);
insert into ANGAJATI values (115, 'Nastase', '04-05-2003', 5200, 1005);
insert into ANGAJATI values (116, 'Afrim', '01-08-2013', 3900, 1006);
insert into ANGAJATI values (117, 'Alexa', '15-12-2015', 4800, 1007);
insert into ANGAJATI values (118, 'Ionita', '21-10-2012', 6700, 1008);
insert into ANGAJATI values (119, 'Bercu', '17-02-2005', 5400, 1009);
insert into ANGAJATI values (120, 'Nita', '18-08-2013', 5500, 1010);
insert into ANGAJATI values (121, 'Plesa', '27-06-2014', 5500, 1011);
insert into ANGAJATI values (122, 'Duta', '05-07-2004', 7200, 1012);
insert into ANGAJATI values (123, 'Hobbs', '03-03-2010', 8900, 1013);
insert into ANGAJATI values (124, 'Sargent', '21-09-2012', 9200, 1014);
insert into ANGAJATI values (125, 'Galloway', '02-02-2006', 10000, 1015);
insert into ANGAJATI values (126, 'Connolly', '04-08-2013', 9500, 1016);
insert into ANGAJATI values (127, 'Holcomb', '05-06-2014', 9800, 1017);
insert into ANGAJATI values (128, 'Sheehan', '08-09-2004', 8800, 1018);

select * from ANGAJATI;

insert into TURN_CONTROL values (900, 600, 30, 1000);
insert into TURN_CONTROL values (910, 1500, 50, 1100);
insert into TURN_CONTROL values (920, 2000, 100, 1200);
insert into TURN_CONTROL values (930, 1900, 80, 1300);
insert into TURN_CONTROL values (940, 2500, 150, 1400);
insert into TURN_CONTROL values (950, 4000, 200, 1500);

select * from TURN_CONTROL;

insert into PASAGERI values (90, 'Popa', 'Romana', 'Germania', 1000);
insert into PASAGERI values (91, 'Phan', 'Chineza', 'Japonia', 1500);
insert into PASAGERI values (92, 'Edwards', 'Irlandeza', 'Argentina', 1200);
insert into PASAGERI values (93, 'Bass', 'Britanica', 'Egipt', 1100);
insert into PASAGERI values (94, 'Senior', 'Canadiana', 'Ungaria', 1300);
insert into PASAGERI values (95, 'Mcclain', 'Americana', 'Finlanda', 1400);
insert into PASAGERI values (100, 'King', 'Romana', 'Italia', 1000);
insert into PASAGERI values (101, 'Liu', 'Chineza', 'Australia', 1500);
insert into PASAGERI values (102, 'Lott', 'Britanica', 'SUA', 1200);
insert into PASAGERI values (103, 'Bishop', 'Canadiana', 'Africa de Sud', 1100);
insert into PASAGERI values (104, 'Medina', 'Italiana', 'Franta', 1300);
insert into PASAGERI values (105, 'Franks', 'Americana', 'Ucraina', 1400);

select * from PASAGERI;

insert into BILETE values (500, 'TAROM', 100, 100);
insert into BILETE values (501, 'KLM', 300, 101);
insert into BILETE values (502, 'British Airways', 200, 102);
insert into BILETE values (503, 'AirChina', 500, 103);
insert into BILETE values (504, 'Delta', 700, 104);
insert into BILETE values (505, 'AirFrance', 400, 105);
insert into BILETE values (506, 'TAROM', 200, 90);
insert into BILETE values (507, 'KLM', 400, 91);
insert into BILETE values (508, 'British Airways', 500, 92);
insert into BILETE values (509, 'AirChina', 400, 93);
insert into BILETE values (510, 'Delta', 800, 94);
insert into BILETE values (511, 'AirFrance', null, 95);

select * from BILETE;

insert into BAGAJE values (10, 'Bucuresti', 1000, 100);
insert into BAGAJE values (11, 'Beijing', 1500, 101);
insert into BAGAJE values (12, 'Londra', 1200, 102);
insert into BAGAJE values (13, 'Amsterdam', 1100, 103);
insert into BAGAJE values (14, 'Paris', 1300, 104);
insert into BAGAJE values (15, 'New York', 1400, 105);
insert into BAGAJE values (16, 'Bucuresti', 1000, 90);
insert into BAGAJE values (17, 'Beijing', 1500, 91);
insert into BAGAJE values (18, 'Londra', 1200, 92);
insert into BAGAJE values (19, 'Amsterdam', 1100, 93);
insert into BAGAJE values (20, 'Paris', 1300, 94);
insert into BAGAJE values (21, 'New York', 1400, 95);

select * from BAGAJE;

insert into DESTINATIE values (3000, 20, 1000, 100);
insert into DESTINATIE values (3100, 15, 1500, 101);
insert into DESTINATIE values (3200, 01, 1200, 102);
insert into DESTINATIE values (3300, 10, 1100, 103);
insert into DESTINATIE values (3400, 19, 1300, 104);
insert into DESTINATIE values (3500, 12, 1400, 105);
insert into DESTINATIE values (3001, 07, 1000, 90);
insert into DESTINATIE values (3101, 15, 1500, 91);
insert into DESTINATIE values (3201, 23, 1200, 92);
insert into DESTINATIE values (3301, 02, 1100, 93);
insert into DESTINATIE values (3401, 21, 1300, 94);
insert into DESTINATIE values (3501, 11, 1400, 95);

select * from DESTINATIE;


insert into COMPANII_AERIENE values (800, 'TAROM', 50, 'Bucuresti', 1000);
insert into COMPANII_AERIENE values (810, 'KLM', 300, 'Amsterdam', 1100);
insert into COMPANII_AERIENE values (820, 'British Airways', 350, 'Londra', 1200);
insert into COMPANII_AERIENE values (830, 'AirFrance', 250, 'Paris', 1300);
insert into COMPANII_AERIENE values (840, 'Delta', 500, 'New York', 1400);
insert into COMPANII_AERIENE values (850, 'AirChina', 400, 'Beijing', 1500);

select * from COMPANII_AERIENE;

insert into AVIOANE values (50, 'Boeing 707', 800);
insert into AVIOANE values (51, 'Boeing 787', 800);
insert into AVIOANE values (52, 'Airbus A300', 810);
insert into AVIOANE values (53, 'Airbus A340', 810);
insert into AVIOANE values (54, 'Airbus A310', 820);
insert into AVIOANE values (55, 'Airbus A330', 820);
insert into AVIOANE values (56, 'Boeing 717', 830);
insert into AVIOANE values (57, 'ATR 42', 830);
insert into AVIOANE values (58, 'Airbus A380', 840);
insert into AVIOANE values (59, 'Airbus A320', 840);
insert into AVIOANE values (60, 'Boeing 777', 850);
insert into AVIOANE values (61, 'Boeing 747', 850);

select * from AVIOANE;

insert into ZBORURI values (5000, 'Bucuresti', 2, 1000, 800);
insert into ZBORURI values (5100, 'Amsterdam', 3, 1100, 810);
insert into ZBORURI values (5200, 'Londra', 5, 1200, 820);
insert into ZBORURI values (5300, 'Paris', 1, 1300, 830);
insert into ZBORURI values (5400, 'New York', 10, 1400, 840);
insert into ZBORURI values (5500, 'Beijing', 8, 1500, 850);

select * from ZBORURI;

insert into PERSONAL values (300, 'Turner', 'Conducere_800', 8000, 800);
insert into PERSONAL values (301, 'Pruitt', 'Conducere_810', 9000, 810);
insert into PERSONAL values (302, 'Stamp', 'Conducere_820', 7000, 820);
insert into PERSONAL values (303, 'Devine', 'Conducere_830', 10000, 830);
insert into PERSONAL values (304, 'Hudson', 'Conducere_840', 6000, 840);
insert into PERSONAL values (305, 'Oritz', 'Conducere_850', 12000, 850);
insert into PERSONAL values (306, 'Parsons', 'Zbor', 10000, 800);
insert into PERSONAL values (307, 'Rankin', 'Zbor', 5000, 810);
insert into PERSONAL values (308, 'Maynard', 'Zbor', 30000, 820);
insert into PERSONAL values (309, 'Durham', 'Zbor', 20000, 830);
insert into PERSONAL values (310, 'Coulson', 'Zbor', 9500, 840);
insert into PERSONAL values (311, 'Parkes', 'Zbor', 15000, 850);

select * from PERSONAL;

insert into PERSONAL_ORGANIZATORIC values (320, 100, 'Manager', 'HR', 300);
insert into PERSONAL_ORGANIZATORIC values (321, 150, 'Manager', 'PR', 301);
insert into PERSONAL_ORGANIZATORIC values (322, 230, 'Manager', 'Marketing', 302);
insert into PERSONAL_ORGANIZATORIC values (323, 125, 'Manager', 'Comercial', 303);
insert into PERSONAL_ORGANIZATORIC values (324, 70, 'Manager', 'Finante', 304);
insert into PERSONAL_ORGANIZATORIC values (325, 90, 'Manager', 'Achizitii', 305);

select * from PERSONAL_ORGANIZATORIC;

insert into PERSONAL_ZBOR values (326, 'Pilot', 200, 1000, 306);
insert into PERSONAL_ZBOR values (327, 'Pilot', 200, 1200, 307);
insert into PERSONAL_ZBOR values (328, 'Pilot', 100, 900, 308);
insert into PERSONAL_ZBOR values (329, 'Stewardesa', 50, 500, 309);
insert into PERSONAL_ZBOR values (330, 'Stewardesa', 90, 800, 310);
insert into PERSONAL_ZBOR values (331, 'Stewardesa', 70, 650, 311);

select * from PERSONAL_ZBOR;

insert into AJUNG values (1000, 10, 100);
insert into AJUNG values (1100, 11, 101);
insert into AJUNG values (1200, 12, 102);
insert into AJUNG values (1300, 13, 103);
insert into AJUNG values (1400, 14, 104);
insert into AJUNG values (1500, 15, 105);
insert into AJUNG values (1000, 16, 90);
insert into AJUNG values (1100, 17, 91);
insert into AJUNG values (1200, 18, 92);
insert into AJUNG values (1300, 19, 93);
insert into AJUNG values (1400, 20, 94);
insert into AJUNG values (1500, 21, 95);

select * from AJUNG;

insert into ESTE_TRANZITAT values (1000, 10);
insert into ESTE_TRANZITAT values (1100, 11);
insert into ESTE_TRANZITAT values (1200, 12);
insert into ESTE_TRANZITAT values (1300, 13);
insert into ESTE_TRANZITAT values (1400, 14);
insert into ESTE_TRANZITAT values (1500, 15);
insert into ESTE_TRANZITAT values (1000, 16);
insert into ESTE_TRANZITAT values (1100, 17);
insert into ESTE_TRANZITAT values (1200, 18);
insert into ESTE_TRANZITAT values (1300, 19);
insert into ESTE_TRANZITAT values (1400, 20);
insert into ESTE_TRANZITAT values (1500, 21);

select * from ESTE_TRANZITAT;

                    


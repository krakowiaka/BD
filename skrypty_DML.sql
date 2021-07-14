ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY";
--------------------------------------------------------------------------------
--STATUS
INSERT INTO status VALUES (901, 'Remont');
INSERT INTO status VALUES (902, 'Zajêty');
INSERT INTO status VALUES (903, 'Wolny');
INSERT INTO status VALUES (904, 'Wy³¹czony');
COMMIT;
--------------------------------------------------------------------------------
--TYP
INSERT INTO typy VALUES (801, 'Stand', 100, 250);
INSERT INTO typy VALUES (802, 'Stand+', 150, 400);
INSERT INTO typy VALUES (803, 'Prem', 250, 500);
INSERT INTO typy VALUES (804, 'Prem+', 350, 700);
COMMIT;
--------------------------------------------------------------------------------
--POKOJE
--STANDARD 
--2os
INSERT INTO pokoje VALUES (201, '20/06/2010', 2, 801, 901); 
INSERT INTO pokoje VALUES (202, '15/06/2010', 2, 801, 901);
INSERT INTO pokoje VALUES (203, '03/03/2016', 2, 801, 903);
INSERT INTO pokoje VALUES (204, '03/03/2016', 2, 801, 903);
--3os
INSERT INTO pokoje VALUES (205, '20/06/2010', 3, 801, 903);
INSERT INTO pokoje VALUES (206, '20/05/2016', 3, 801, 903);
INSERT INTO pokoje VALUES (207, '20/06/2016', 3, 801, 903); 
--4os
INSERT INTO pokoje VALUES (208, '15/06/2019', 4, 801, 903);
INSERT INTO pokoje VALUES (209, '03/03/2016', 4, 801, 903);
INSERT INTO pokoje VALUES (210, '21/05/2005', 4, 801, 901);
INSERT INTO pokoje VALUES (211, '15/06/2018', 4, 801, 904); 
INSERT INTO pokoje VALUES (212, '15/06/2020', 4, 801, 904);
--STABDARD+
--2os
INSERT INTO pokoje VALUES (213, '20/06/2010', 2, 802, 901); 
INSERT INTO pokoje VALUES (214, '15/06/2019', 2, 802, 903);
INSERT INTO pokoje VALUES (215, '15/06/2019', 2, 802, 903);
INSERT INTO pokoje VALUES (216, '15/06/2019', 2, 802, 903);
--3os
INSERT INTO pokoje VALUES (217, '15/06/2019', 3, 802, 903);
INSERT INTO pokoje VALUES (218, '15/06/2019', 3, 802, 903);
INSERT INTO pokoje VALUES (219, '15/06/2019', 3, 802, 903);
--4os
INSERT INTO pokoje VALUES (220, '20/06/2010', 4, 802, 903); 
INSERT INTO pokoje VALUES (221, '15/06/2019', 4, 802, 903);
INSERT INTO pokoje VALUES (222, '15/06/2019', 4, 802, 903);
--PREMIUM
--2os
INSERT INTO pokoje VALUES (223, '15/06/2018', 2, 803, 903);
INSERT INTO pokoje VALUES (224, '15/06/2018', 2, 803, 903);
INSERT INTO pokoje VALUES (225, '15/06/2018', 2, 803, 903);
INSERT INTO pokoje VALUES (226, '15/06/2018', 2, 803, 903);
--3os
INSERT INTO pokoje VALUES (227, '15/10/2019', 3, 803, 903);
INSERT INTO pokoje VALUES (228, '15/10/2019', 3, 803, 903);
INSERT INTO pokoje VALUES (229, '15/10/2019', 3, 803, 903);
--4os
INSERT INTO pokoje VALUES (230, '15/10/2019', 4, 803, 903);
INSERT INTO pokoje VALUES (231, '15/10/2019', 4, 803, 903);
--PREMIUM+
INSERT INTO pokoje VALUES (232, '15/06/2020', 2, 804, 903);
INSERT INTO pokoje VALUES (233, '15/06/2020', 2, 804, 903);
COMMIT;
--------------------------------------------------------------------------------
--ADRESY
INSERT INTO adresy VALUES (301, 'Czestochowska', 5, 'Sopot');
INSERT INTO adresy VALUES (302, 'Gdañska', 3, 'Czêstochowa');
INSERT INTO adresy VALUES (303, 'Warszawska', 45, 'Gdynia');
INSERT INTO adresy VALUES (304, 'Wroc³awska', 67, 'Szczecin');
INSERT INTO adresy VALUES (305, 'Ziemowita', 7, 'Sopot');
INSERT INTO adresy VALUES (306, 'Bronka', 88, 'Gdynia');
INSERT INTO adresy VALUES (307, 'Ry¿owa', 78, 'Sopot');
INSERT INTO adresy VALUES (308, 'Piêkna', 99, 'Sopot');
COMMIT;
--------------------------------------------------------------------------------
--STANOWISKA
INSERT INTO stanowiska VALUES (101, 'Recepcjonista');
INSERT INTO stanowiska VALUES (102, 'Kucharz');
INSERT INTO stanowiska VALUES (103, 'Sprz¹tacz');
INSERT INTO stanowiska VALUES (104, 'Kierownik nocny');
INSERT INTO stanowiska VALUES (105, 'Kierownik dzienny');
INSERT INTO stanowiska VALUES (106, 'Konserwator');
INSERT INTO stanowiska VALUES (107, 'Ochroniarz');
INSERT INTO stanowiska VALUES (108, 'Kelner');
COMMIT;
--------------------------------------------------------------------------------
--PIÊTRA
INSERT INTO pietra VALUES (601, 1);
INSERT INTO pietra VALUES (602, 2);
INSERT INTO pietra VALUES (603, 3);
INSERT INTO pietra VALUES (604, 4);
INSERT INTO pietra VALUES (605, 5);
INSERT INTO pietra VALUES (606, 6);
INSERT INTO pietra VALUES (607, 7);
INSERT INTO pietra VALUES (608, 8);
INSERT INTO pietra VALUES (609, 9);
INSERT INTO pietra VALUES (610, 10);
INSERT INTO pietra VALUES (611, 0);
INSERT INTO pietra VALUES (612, -1);
COMMIT;
--------------------------------------------------------------------------------
--PRACOWNICY
INSERT INTO pracownicy VALUES (701, 'Piotr', 'Maciejewski', 'M', 302, 104, 611);
INSERT INTO pracownicy VALUES (702, 'Piotr', 'Janowski', 'M', 306, 105, 611);

INSERT INTO pracownicy VALUES (703, 'Jadwiga', 'Nowacka', 'K', 303, 101, 611);
INSERT INTO pracownicy VALUES (704, 'Beata', 'Mucha', 'K', 302, 101, 611);
INSERT INTO pracownicy VALUES (705, 'Bartosz', 'Pawlak', 'M', 301, 101, 611);

INSERT INTO pracownicy VALUES (706, 'S³awomir', 'Wiœniewski', 'M', 307, 102, 612);
INSERT INTO pracownicy VALUES (707, 'Grzegorz', 'Bednarek', 'M', 307, 102, 612);
INSERT INTO pracownicy VALUES (708, 'Konstanty', 'Cugowski', 'M', 307, 102, 612);
INSERT INTO pracownicy VALUES (709, 'Ziemowit', 'Szpak', 'M', 307, 102, 612);
INSERT INTO pracownicy VALUES (710, 'Krzysztof', 'Schetyna', 'M', 307, 102, 612);
INSERT INTO pracownicy VALUES (711, 'Ludmi³a', 'Stachurska', 'K', 307, 102, 612);

INSERT INTO pracownicy VALUES (712, 'Robert', 'Milik', 'M', 308, 107, 611);
INSERT INTO pracownicy VALUES (713, 'Arkadiusz', 'Lewandowski', 'M', 308, 107, 611);

INSERT INTO pracownicy VALUES (714, 'Beata', 'Rabczewska', 'K', 301, 108, 611);
INSERT INTO pracownicy VALUES (715, 'Dorota', 'Kozidrak', 'K', 301, 108, 611);
INSERT INTO pracownicy VALUES (716, 'Janusz', 'Wojewódzki', 'M', 301, 108, 611);
INSERT INTO pracownicy VALUES (717, 'Miko³aj', 'Œmietanka', 'M', 301, 108, 611);

INSERT INTO pracownicy VALUES (718, 'Jan', 'Niezgódka', 'M', 308, 106, 612);

INSERT INTO pracownicy VALUES (719, 'Maria', 'Niepogoda', 'K', 305, 103, 611);
INSERT INTO pracownicy VALUES (720, 'Maja', 'Niepogoda', 'K', 305, 103, 601);
INSERT INTO pracownicy VALUES (721, 'Natalia', 'Balon', 'K', 305, 103, 602);
INSERT INTO pracownicy VALUES (722, 'Paulina', 'Wiatr', 'K', 305, 103, 603);
INSERT INTO pracownicy VALUES (723, 'Aleksandra', 'Niezgodna', 'K', 305, 103, 604);
INSERT INTO pracownicy VALUES (724, 'Ma³gorzata', 'King', 'K',305, 103, 605);
INSERT INTO pracownicy VALUES (725, 'Amadeusz', 'Bach', 'M', 305, 103, 606);
INSERT INTO pracownicy VALUES (726, 'Sebastian', 'Mozart', 'M', 305, 103, 607);
INSERT INTO pracownicy VALUES (727, 'Katarzyna', 'Samosia', 'K', 305, 103, 608);
INSERT INTO pracownicy VALUES (728, 'Maria', 'Samosia', 'K', 305, 103, 609);
INSERT INTO pracownicy VALUES (729, 'Wies³awa', 'Krupa', 'K', 305, 103, 610);
INSERT INTO pracownicy VALUES (730, 'Bronis³awa', 'Koper', 'K', 305, 103, 610);
COMMIT;
--------------------------------------------------------------------------------
--GRUPY
INSERT INTO grupy VALUES (501, 101);
INSERT INTO grupy VALUES (502, 105);
INSERT INTO grupy VALUES (503, 107);
INSERT INTO grupy VALUES (504, 108);
INSERT INTO grupy VALUES (505, 113);
INSERT INTO grupy VALUES (506, 119);
INSERT INTO grupy VALUES (507, 120);
INSERT INTO grupy VALUES (508, 128);
COMMIT;
--------------------------------------------------------------------------------
--GOŒCIE
INSERT INTO goscie VALUES(101, 'Jan', 'Kowalski', 'M', 45, 501, 101);
INSERT INTO goscie VALUES(102, 'Anna', 'Kowalska', 'K', 40, 501, 101);
INSERT INTO goscie VALUES(103, 'Ewa', 'Kowalska', 'K', 5, 501, 101);
INSERT INTO goscie VALUES(104, 'Adam', 'Kowalska', 'M', 5, 501, 101);

INSERT INTO goscie VALUES(105, 'Piotr', 'Nowak', 'M', 25, 502, 105);
INSERT INTO goscie VALUES(106, 'Aleksandra', 'Kowalczyk', 'K', 25, 502, 105);

INSERT INTO goscie VALUES(107, 'Julia', 'Wójcik', 'K', 35, 503, 107);

INSERT INTO goscie VALUES(108, 'Janusz', 'Wiœniewski', 'M', 50, 504, 108);
INSERT INTO goscie VALUES(109, 'Gra¿yna', 'Wiœniewska', 'K', 49, 504, 108);
INSERT INTO goscie VALUES(110, 'Jess', 'Wiœniewska', 'K', 14, 504, 108);
INSERT INTO goscie VALUES(111, 'Wies³awa', 'Wiœniewska', 'K', 75, 504, 108);
INSERT INTO goscie VALUES(112, 'Wies³aw', 'Wiœniewski', 'M', 80, 504, 108);

INSERT INTO goscie VALUES(113, 'Bogus³awa', 'Kamiñska', 'K', 24, 505, 113);
INSERT INTO goscie VALUES(114, 'Karolina', 'Kubiak', 'K', 23, 505, 113);
INSERT INTO goscie VALUES(115, 'Joanna', 'Kurek', 'K', 25, 505, 113);
INSERT INTO goscie VALUES(116, 'Aleksandra', 'Winiarska', 'K', 24, 505, 113);
INSERT INTO goscie VALUES(117, 'Ada', 'Œliwka', 'K', 24, 505, 113);
INSERT INTO goscie VALUES(118, 'Julia', 'Wrona', 'K', 25, 505, 113);

INSERT INTO goscie VALUES(119, 'Patryk', 'Radecki', 'M', 39, 506, 119);

INSERT INTO goscie VALUES(120, 'Katarzyna', 'Zatorska', 'K', 52, 507, 120);
INSERT INTO goscie VALUES(121, 'Robert', 'Zatorski', 'M', 55, 507, 120);
INSERT INTO goscie VALUES(122, 'Ignacy', 'Zatorski', 'M', 20, 507, 120);
INSERT INTO goscie VALUES(123, 'Jan', 'Zatorski', 'M', 24, 507, 120);
INSERT INTO goscie VALUES(124, 'Dominika', 'Wojtaszek', 'K', 48, 507, 120);
INSERT INTO goscie VALUES(125, 'Pawe³', 'Wojtaszek', 'M', 49, 507, 120);
INSERT INTO goscie VALUES(126, 'Kacper', 'Wojtaszek', 'M', 10, 507, 120);
INSERT INTO goscie VALUES(127, 'Rados³aw', 'Wojtaszek', 'M', 20, 507, 120);

INSERT INTO goscie VALUES(128, 'Jan', 'Morawiecki', 'M', 28, 508, 128);
INSERT INTO goscie VALUES(129, 'Patryk', 'Sasin', 'M', 27, 508, 128);
INSERT INTO goscie VALUES(130, 'Piotr', 'Budka', 'M', 29, 508, 128);
COMMIT;
--------------------------------------------------------------------------------
--ZNI¯KI
INSERT INTO znizki VALUES (206, '31/01/2021', '31/03/2021', 0.15, 'zima/wiosna');  
INSERT INTO znizki VALUES (207, '30/09/2021', '30/11/2021', 0.10, 'jesien/zima'); 
INSERT INTO znizki VALUES (208, '01/07/2021', '31/08/2021', 0.05, 'lato');
COMMIT;
--------------------------------------------------------------------------------
--ATRAKCJE
INSERT INTO atrakcje VALUES (201, 'Basen', 20);
INSERT INTO atrakcje VALUES (202, 'SPA', 250);
INSERT INTO atrakcje VALUES (203, 'Tenis', 100);
INSERT INTO atrakcje VALUES (204, 'Krêgle', 50);
INSERT INTO atrakcje VALUES (205, 'Kolacja z winem,', 300);
COMMIT;
--------------------------------------------------------------------------------
--REZERWACJE
INSERT INTO rezerwacje VALUES (101, '14/02/2021', '21/02/2021', 2500, 703, 206, 208, null);

INSERT INTO rezerwacje VALUES (102, '14/05/2021', '17/05/2021', 2700, 703, null, 232, 205);

INSERT INTO rezerwacje VALUES (103, '15/06/2021', '17/06/2021', 500, 701, null, 203, 202);

INSERT INTO rezerwacje VALUES (104, '01/07/2021', '14/07/2021', 8000, 705, 208, 205, 201);
INSERT INTO rezerwacje VALUES (105, '01/07/2021', '14/07/2021', 10000, 705, 208, 214,201);

INSERT INTO rezerwacje VALUES (106, '01/09/2021', '07/09/2021', 5000, 704, null, 217, 201);
INSERT INTO rezerwacje VALUES (107, '01/09/2021', '07/09/2021', 5000, 704, null, 218, 201);

INSERT INTO rezerwacje VALUES (108, '20/11/2021', '24/11/2021', 600, 704, 207, 223, null);

INSERT INTO rezerwacje VALUES (109, '28/06/2021', '14/07/2021', 8000, 702, 208, 203,203);
INSERT INTO rezerwacje VALUES (110, '28/06/2021', '14/07/2021', 9000, 702, 208, 206,202);
INSERT INTO rezerwacje VALUES (111, '28/06/2021', '14/07/2021', 9500, 702, 208, 207,204);

INSERT INTO rezerwacje VALUES (112, '05/09/2021', '07/09/2021', 2500, 703, null, 229, 205);
COMMIT;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--GRUPA_REZERW
INSERT INTO grupa_rezerw VALUES (301, 501, 101); -- jeden 4-osobowy standard

INSERT INTO grupa_rezerw VALUES (302, 502, 102); -- jeden 2-osobowy premium+

INSERT INTO grupa_rezerw VALUES (303, 503, 103); -- jeden 2-osobowy standard ale 1 osoba

INSERT INTO grupa_rezerw VALUES (304, 504, 104); -- jeden 3-osobowy standard
INSERT INTO grupa_rezerw VALUES (305, 504, 105); -- jeden 2-osobowy standard+

INSERT INTO grupa_rezerw VALUES (306, 505, 106); -- jeden 3-osobowy standard+
INSERT INTO grupa_rezerw VALUES (307, 505, 107); -- jeden 3-osobowy standard+

INSERT INTO grupa_rezerw VALUES (308, 506, 108); -- jeden 2-osobowy premium ale 1 osoba

INSERT INTO grupa_rezerw VALUES (309, 507, 109); -- jeden 2-osobowy standard
INSERT INTO grupa_rezerw VALUES (310, 507, 110); -- jeden 3-osobowy standard
INSERT INTO grupa_rezerw VALUES (311, 507, 111); -- jeden 3-osobowy standard

INSERT INTO grupa_rezerw VALUES (312, 508, 112); -- jeden 3-osobowy premium
COMMIT;
--------------------------------------------------------------------------------
--PIETRO_POKOJ
INSERT INTO pietro_pokoj VALUES(301, 601, 208);
INSERT INTO pietro_pokoj VALUES(302, 601, 207);
INSERT INTO pietro_pokoj VALUES(303, 601, 201);
INSERT INTO pietro_pokoj VALUES(304, 601, 202);
INSERT INTO pietro_pokoj VALUES(305, 602, 209);
INSERT INTO pietro_pokoj VALUES(306, 602, 210);
INSERT INTO pietro_pokoj VALUES(307, 602, 203);
INSERT INTO pietro_pokoj VALUES(308, 602, 205);
INSERT INTO pietro_pokoj VALUES(309, 603, 211);
INSERT INTO pietro_pokoj VALUES(310, 603, 212);
INSERT INTO pietro_pokoj VALUES(311, 603, 204);
INSERT INTO pietro_pokoj VALUES(312, 603, 206);
INSERT INTO pietro_pokoj VALUES(313, 604, 220);
INSERT INTO pietro_pokoj VALUES(314, 604, 221);
INSERT INTO pietro_pokoj VALUES(315, 604, 213);
INSERT INTO pietro_pokoj VALUES(316, 604, 214);
INSERT INTO pietro_pokoj VALUES(317, 605, 222);
INSERT INTO pietro_pokoj VALUES(318, 605, 217);
INSERT INTO pietro_pokoj VALUES(319, 605, 215);
INSERT INTO pietro_pokoj VALUES(320, 606, 218);
INSERT INTO pietro_pokoj VALUES(321, 606, 219);
INSERT INTO pietro_pokoj VALUES(322, 606, 216);
INSERT INTO pietro_pokoj VALUES(323, 607, 227);
INSERT INTO pietro_pokoj VALUES(324, 607, 228);
INSERT INTO pietro_pokoj VALUES(325, 607, 223);
INSERT INTO pietro_pokoj VALUES(326, 608, 230);
INSERT INTO pietro_pokoj VALUES(327, 608, 231);
INSERT INTO pietro_pokoj VALUES(328, 608, 224);
INSERT INTO pietro_pokoj VALUES(329, 609, 229);
INSERT INTO pietro_pokoj VALUES(330, 609, 225);
INSERT INTO pietro_pokoj VALUES(331, 609, 226);
INSERT INTO pietro_pokoj VALUES(332, 610, 232);
INSERT INTO pietro_pokoj VALUES(333, 610, 233);
COMMIT;
--------------------------------------------------------------------------------
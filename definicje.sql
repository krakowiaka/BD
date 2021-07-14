--PROCEDURY
/** Procedura, kt�ra umo�liwia realizacj� zmiany statusu pokoju
    na remont, je�li jego wczesniejsza renowacja by�a przed 2015
*/
CREATE OR replace PROCEDURE zmiana_statusu_remont(pok_id NUMBER)
AS
    v_status_id pokoje.status_id%TYPE;
    v_data_renowacji pokoje.data_renowacji%TYPE;
BEGIN
        SELECT status_id, v_data_renowacji
        INTO v_status_id, v_data_renowacji
        FROM pokoje
        WHERE pokoj_id = pok_id;
   
        IF v_status_id = 903 AND EXTRACT(YEAR FROM v_data_renowacji) < 2015 THEN
            UPDATE pokoje SET status_id = 901;
        ELSE
            dbms_output.put_line ('Pok�j nie mo�e by� oddany do remontu');
        END IF;   
END;
/
/** Procedura, kt�ra umo�liwia zmian� atrakcji podczas pobytu
    wraz z update koszt�w pobytu
*/
CREATE OR replace PROCEDURE zmiana_atrakcji(rezerw_id NUMBER, atrak_id NUMBER)
AS
    v_atrak_id_old rezerwacje.atrakcja_id%TYPE;
    v_atrak_koszt_old atrakcje.koszt%TYPE;
    v_atrak_koszt_new atrakcje.koszt%TYPE;
    v_roznica atrakcje.koszt%TYPE;
BEGIN
        SELECT a.atrakcja_id, a.koszt 
        INTO v_atrak_id_old, v_atrak_koszt_old
        FROM rezerwacje r JOIN atrakcje a ON r.atrakcja_id = a.atrakcja_id
        WHERE r.rezerwacja_id = rezerw_id;
        
        SELECT koszt
        INTO v_atrak_koszt_new
        FROM atrakcje
        WHERE atrakcja_id = atrak_id;
        
        v_roznica := v_atrak_koszt_new - v_atrak_koszt_old;
        
        IF v_atrak_id_old != atrak_id THEN
            UPDATE rezerwacje SET atrakcja_id = atrak_id, koszt = koszt + v_roznica
            WHERE rezerwacja_id = rezerw_id;
            dbms_output.put_line ('Uaktualniono atrakcj�');
        ELSE
            dbms_output.put_line ('Atrkacja zosta�a ju� wybrana!');
        END IF;
END;
/
--FUNKCJE
/**Funkcja, kt�ra generuje kod dost�pu do systemu komupterowego dla ka�dego 
    pracownika
*/
CREATE OR REPLACE FUNCTION kod_dostepu(prac_id NUMBER)
RETURN VARCHAR2
AS 
    v_kod_p VARCHAR(5);
    v_kod VARCHAR(5);
BEGIN
    SELECT CONCAT(SUBSTR(imie,1,1), SUBSTR(nazwisko,1,1))
    INTO v_kod_p
    FROM pracownicy
    WHERE pracownik_id = prac_id;
    
    SELECT CONCAT(TO_CHAR(pracownik_id), v_kod_p)
    INTO v_kod
    FROM pracownicy
    WHERE pracownik_id = prac_id;
    
RETURN v_kod;
END;
/
/**Funkcja kt�ra umo�liwia obliczenia ile dany pracownik wykona� rezerwacji
*/
CREATE OR REPLACE FUNCTION ilosc_rezer(prac_id NUMBER)
RETURN NUMBER
AS
    c_ilosc NUMBER;
BEGIN
    SELECT COUNT(rezerwacja_id)
    INTO c_ilosc
    FROM rezerwacje 
    WHERE pracownik_id = prac_id;
    
    IF c_ilosc > 1 THEN
        dbms_output.put_line('Pracownik o id: ' || prac_id || ' dokona� ' || c_ilosc || ' rezerwacji.' );
    ELSE
        dbms_output.put_line('Pracownik nie ma uprawnie� do dokonywania rezerwacji!');
    END IF;
RETURN c_ilosc;
END;
/
--WYZWALACZE
/** Wyzwalacz, kt�ry uniemo�liwia rezerwacje pokoju, 
    kt�ry nie jest wolny. Pr�ba dodania rezerwacji pokoju
    o z�ym statusie zostaje powstrzymana
*/
CREATE OR REPLACE TRIGGER ostrzezenie_zly_status
BEFORE INSERT ON rezerwacje FOR EACH ROW
DECLARE
    v_status_id pokoje.status_id%TYPE;
BEGIN
    SELECT status_id
    INTO v_status_id
    FROM pokoje WHERE pokoj_id =: new.pokoj_id;
    
    IF v_status_id = 901 OR v_status_id = 904 THEN
        dbms_output.put_line('Pok�j w remoncie/wy��czony');
        raise_application_error(-20001, 'Rezerwacja niedokonana');
    ELSIF v_status_id = 902 THEN
        dbms_output.put_line('Pok�j zaj�ty! Sprawd� do kiedy!');
        raise_application_error(-20002, 'Rezerwacja niedokonana');
    ELSE
        dbms_output.put_line('Rezerwacja posz�a pomy�lnie!');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER ostrzezenie_dziecko
BEFORE INSERT ON goscie FOR EACH ROW
DECLARE
BEGIN
    IF :new.wiek < 5 THEN
        dbms_output.put_line('Dziecko! Nie liczone w koszty!');
    END IF;
END;
/
--SPRAWDZENIE DZIA�ANIA
--FUNKCJE

--Poka� kody dost�pu dla pracownik�w, kt�rzy pracuj� na stanowisku kucharz
SELECT kod_dostepu(p.pracownik_id) AS kod
FROM pracownicy p JOIN stanowiska s USING (stanowisko_id)
WHERE s.nazwa = 'Kucharz';

--Poka� imi�, nazwisko, nazw� stanowiska oraz ilo�� dokonany rezerwacji
--przez pracownika o danym ID
SELECT p.imie, p.nazwisko, s.nazwa ,ilosc_rezer(pracownik_id) AS ilosc
FROM pracownicy p JOIN stanowiska s USING (stanowisko_id)
WHERE pracownik_id = 705;

--PROCEDURY

--Wywo�aj procedur� do zmiany atrakcji w rezerwacji 104 na atrakcj� SPA
BEGIN
    zmiana_atrakcji(104,202);
END;
/

--Wywo�aj procedur� do zmianu statusu pokoju o id - 232
BEGIN
    zmiana_statusu_remont(232);
END;
/

--WYZWALACZE

--Stw�rz grup�, kt�ra b�dzie posiada�a jedn� osob� oraz z�� rezerwacje na pok�j 201
INSERT INTO grupy VALUES (509, 131);
INSERT INTO goscie VALUES(131, 'Ola', 'Sprawdzenie', 'K', 25, 509, 131);
INSERT INTO rezerwacje VALUES (113, '07/06/2021', '08/06/2021', 2500, 703, null, 201, 205);

--Dodaj do listy go�ci dziecko, kt�re ma mniej ni� 5 lat
INSERT INTO goscie VALUES(132, 'Asia', 'Sprawdzenie', 'K', 2, 509, 131);
--PROCEDURY
/** Procedura, która umo¿liwia realizacjê zmiany statusu pokoju
    na remont, jeœli jego wczesniejsza renowacja by³a przed 2015
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
            dbms_output.put_line ('Pokój nie mo¿e byæ oddany do remontu');
        END IF;   
END;
/
/** Procedura, która umo¿liwia zmianê atrakcji podczas pobytu
    wraz z update kosztów pobytu
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
            dbms_output.put_line ('Uaktualniono atrakcjê');
        ELSE
            dbms_output.put_line ('Atrkacja zosta³a ju¿ wybrana!');
        END IF;
END;
/
--FUNKCJE
/**Funkcja, która generuje kod dostêpu do systemu komupterowego dla ka¿dego 
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
/**Funkcja która umo¿liwia obliczenia ile dany pracownik wykona³ rezerwacji
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
        dbms_output.put_line('Pracownik o id: ' || prac_id || ' dokona³ ' || c_ilosc || ' rezerwacji.' );
    ELSE
        dbms_output.put_line('Pracownik nie ma uprawnieñ do dokonywania rezerwacji!');
    END IF;
RETURN c_ilosc;
END;
/
--WYZWALACZE
/** Wyzwalacz, który uniemo¿liwia rezerwacje pokoju, 
    który nie jest wolny. Próba dodania rezerwacji pokoju
    o z³ym statusie zostaje powstrzymana
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
        dbms_output.put_line('Pokój w remoncie/wy³¹czony');
        raise_application_error(-20001, 'Rezerwacja niedokonana');
    ELSIF v_status_id = 902 THEN
        dbms_output.put_line('Pokój zajêty! SprawdŸ do kiedy!');
        raise_application_error(-20002, 'Rezerwacja niedokonana');
    ELSE
        dbms_output.put_line('Rezerwacja posz³a pomyœlnie!');
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
--SPRAWDZENIE DZIA£ANIA
--FUNKCJE

--Poka¿ kody dostêpu dla pracowników, którzy pracuj¹ na stanowisku kucharz
SELECT kod_dostepu(p.pracownik_id) AS kod
FROM pracownicy p JOIN stanowiska s USING (stanowisko_id)
WHERE s.nazwa = 'Kucharz';

--Poka¿ imiê, nazwisko, nazwê stanowiska oraz iloœæ dokonany rezerwacji
--przez pracownika o danym ID
SELECT p.imie, p.nazwisko, s.nazwa ,ilosc_rezer(pracownik_id) AS ilosc
FROM pracownicy p JOIN stanowiska s USING (stanowisko_id)
WHERE pracownik_id = 705;

--PROCEDURY

--Wywo³aj procedurê do zmiany atrakcji w rezerwacji 104 na atrakcjê SPA
BEGIN
    zmiana_atrakcji(104,202);
END;
/

--Wywo³aj procedurê do zmianu statusu pokoju o id - 232
BEGIN
    zmiana_statusu_remont(232);
END;
/

--WYZWALACZE

--Stwórz grupê, która bêdzie posiada³a jedn¹ osobê oraz z³ó¿ rezerwacje na pokój 201
INSERT INTO grupy VALUES (509, 131);
INSERT INTO goscie VALUES(131, 'Ola', 'Sprawdzenie', 'K', 25, 509, 131);
INSERT INTO rezerwacje VALUES (113, '07/06/2021', '08/06/2021', 2500, 703, null, 201, 205);

--Dodaj do listy goœci dziecko, które ma mniej ni¿ 5 lat
INSERT INTO goscie VALUES(132, 'Asia', 'Sprawdzenie', 'K', 2, 509, 131);
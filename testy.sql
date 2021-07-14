/*Wylistuj wszystkie rezerwacje, których koszt 
jest wiêkszy ni¿ 3000.
*/
SELECT rezerwacja_id, koszt
FROM rezerwacje 
WHERE koszt > 3000;

/*Wylistuj pracowników, którzy pracuj¹ na piêtrze 3,9,10
*/
SELECT p.pracownik_id, p.imie, p.nazwisko, pt.poziom
FROM pracownicy p JOIN pietra pt ON p.pietro_id = pt.pietro_id
WHERE pt.pietro_id = 603 OR pt.pietro_id = 609 OR pt.pietro_id = 610;

/*Poka¿ 5 rezerwacji, których koszt jest najwiêkszy
*/
SELECT rezerwacja_id, koszt
FROM rezerwacje
ORDER BY koszt DESC
FETCH FIRST 5 ROWS ONLY;

/* Zapytanie, które wyœwietli informacjê o aktualnych statusach
pokoi
*/
SELECT s.nazwa, COUNT(p.status_id)
FROM status s JOIN pokoje p ON s.status_id = p.status_id
GROUP BY nazwa;

/*Zapytanie, które wyœlwietli œredni¹ wartoœæ kosztu rezerwacji 
przyjêtego przez pracownika 703 i 705
*/
SELECT pracownik_id, ROUND(AVG(koszt),2) koszt
FROM rezerwacje
GROUP BY pracownik_id
HAVING pracownik_id IN (703, 705);

/* Zwróæ id, imiê, nazwisko, miasto i nazwê stawiska
kobiet pracowników
*/
SELECT p.pracownik_id, p.imie, p.nazwisko, a.miasto, s.nazwa
FROM pracownicy p JOIN adresy a USING (adres_id)
JOIN stanowiska s USING (stanowisko_id)
WHERE p.plec = 'K';

/* Zwróæ informacje o goœciach z rezerwacji 112
*/
SELECT g.gosc_id, g.imie, g.nazwisko FROM goscie g 
JOIN grupy gr ON g.grupa_id = gr.grupa_id
JOIN grupa_rezerw gre ON gr.grupa_id = gre.grupa_id
JOIN  rezerwacje r ON gre.rezerwacja_id = r.rezerwacja_id
WHERE r.rezerwacja_id = 112;

/* Zwróæ dane rezerwacji o najwiêkszym koszcie
*/
SELECT * FROM rezerwacje
WHERE koszt = (SELECT MAX(koszt)
                FROM rezerwacje);

/* Zwróæ dane goœcia, który jest najm³odszy i jest dziewczynk¹
*/
SELECT imie, nazwisko, wiek
FROM goscie
WHERE (wiek, plec) = ( SELECT MIN(wiek), 'K'
                        FROM goscie
                        WHERE plec = 'K');
                        
/* Zwróc dane goœci których orgranizator ma id = 108
*/
SELECT * FROM goscie
WHERE grupa_id IN 
(SELECT grupa_id
    FROM grupy
    WHERE organizator_id = 108);

/*Zwróæ wszystkich orgranizatorów
*/
SELECT * FROM goscie g1
WHERE EXISTS
(
    SELECT g2.gosc_id
    FROM goscie g2
    WHERE g1.gosc_id = g2.organizator_id);

--KURSORY
BEGIN 
FOR kursor_nie IN (SELECT p.imie AS imie, 
                    p.nazwisko AS nazwisko, 
                    s.nazwa AS stanowisko,
                    a.miasto AS miasto
                    FROM pracownicy p JOIN  stanowiska s USING (stanowisko_id)
                    JOIN adresy a USING (adres_id)
                    WHERE p.plec = 'K')
LOOP
    dbms_output.put_line('Dane prac.: ' || kursor_nie.imie || ' ' || kursor_nie.nazwisko 
    || ' ' || kursor_nie.stanowisko || ' ' || kursor_nie.miasto);
END LOOP;
END;
/
DECLARE
CURSOR kursor_jaw IS
    SELECT * FROM goscie
    WHERE wiek < 15;
v_wynik goscie%ROWTYPE;
BEGIN
    OPEN kursor_jaw;
    LOOP
        EXIT WHEN kursor_jaw%NOTFOUND;
        FETCH kursor_jaw INTO v_wynik;
        dbms_output.put_line('Podstawowe dane gosci: ' || v_wynik.imie || ' ' ||
        v_wynik.nazwisko || ' ' || v_wynik.wiek || ' ' || v_wynik.plec) ;
     END LOOP;
     CLOSE kursor_jaw;
END;
/
--SEKWENCJE
CREATE SEQUENCE sek1p start with 100 maxvalue 2000 INCREMENT BY 2;
SELECT sek1p.NEXTVAL FROM dual;
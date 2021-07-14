/*Wylistuj wszystkie rezerwacje, kt�rych koszt 
jest wi�kszy ni� 3000.
*/
SELECT rezerwacja_id, koszt
FROM rezerwacje 
WHERE koszt > 3000;

/*Wylistuj pracownik�w, kt�rzy pracuj� na pi�trze 3,9,10
*/
SELECT p.pracownik_id, p.imie, p.nazwisko, pt.poziom
FROM pracownicy p JOIN pietra pt ON p.pietro_id = pt.pietro_id
WHERE pt.pietro_id = 603 OR pt.pietro_id = 609 OR pt.pietro_id = 610;

/*Poka� 5 rezerwacji, kt�rych koszt jest najwi�kszy
*/
SELECT rezerwacja_id, koszt
FROM rezerwacje
ORDER BY koszt DESC
FETCH FIRST 5 ROWS ONLY;

/* Zapytanie, kt�re wy�wietli informacj� o aktualnych statusach
pokoi
*/
SELECT s.nazwa, COUNT(p.status_id)
FROM status s JOIN pokoje p ON s.status_id = p.status_id
GROUP BY nazwa;

/*Zapytanie, kt�re wy�lwietli �redni� warto�� kosztu rezerwacji 
przyj�tego przez pracownika 703 i 705
*/
SELECT pracownik_id, ROUND(AVG(koszt),2) koszt
FROM rezerwacje
GROUP BY pracownik_id
HAVING pracownik_id IN (703, 705);

/* Zwr�� id, imi�, nazwisko, miasto i nazw� stawiska
kobiet pracownik�w
*/
SELECT p.pracownik_id, p.imie, p.nazwisko, a.miasto, s.nazwa
FROM pracownicy p JOIN adresy a USING (adres_id)
JOIN stanowiska s USING (stanowisko_id)
WHERE p.plec = 'K';

/* Zwr�� informacje o go�ciach z rezerwacji 112
*/
SELECT g.gosc_id, g.imie, g.nazwisko FROM goscie g 
JOIN grupy gr ON g.grupa_id = gr.grupa_id
JOIN grupa_rezerw gre ON gr.grupa_id = gre.grupa_id
JOIN  rezerwacje r ON gre.rezerwacja_id = r.rezerwacja_id
WHERE r.rezerwacja_id = 112;

/* Zwr�� dane rezerwacji o najwi�kszym koszcie
*/
SELECT * FROM rezerwacje
WHERE koszt = (SELECT MAX(koszt)
                FROM rezerwacje);

/* Zwr�� dane go�cia, kt�ry jest najm�odszy i jest dziewczynk�
*/
SELECT imie, nazwisko, wiek
FROM goscie
WHERE (wiek, plec) = ( SELECT MIN(wiek), 'K'
                        FROM goscie
                        WHERE plec = 'K');
                        
/* Zwr�c dane go�ci kt�rych orgranizator ma id = 108
*/
SELECT * FROM goscie
WHERE grupa_id IN 
(SELECT grupa_id
    FROM grupy
    WHERE organizator_id = 108);

/*Zwr�� wszystkich orgranizator�w
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
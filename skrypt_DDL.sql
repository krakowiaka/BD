/**Przygotowanie do stworzenia schematu 
Procedura usuwaj¹ca tebele, jeœli takie istniej¹
*/
DECLARE
    v_count  INT;
    v_name VARCHAR2(20);
    TYPE namesarray IS VARRAY(15) OF VARCHAR2(20);
    names    namesarray;
BEGIN
    names := namesarray('status', 'typy', 'pokoje', 'adresy', 'stanowiska', 'pietra',
                       'pracownicy', 'grupy', 'goscie', 'znizki',
                       'atrakcje', 'rezerwacje', 'grupa_rezerw',
                       'pietro_pokoj');

    FOR i IN 1..names.count LOOP
        v_name := names(i);
        
        SELECT COUNT(*) INTO v_count FROM user_tables WHERE table_name = upper(v_name);
        IF v_count = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Dropping table: ' || v_name);
            EXECUTE IMMEDIATE 'DROP TABLE '|| v_name || ' CASCADE CONSTRAINTS';
        END IF;
    END LOOP;
END;
/
/** Stworzenie poszczególnych tabel oraz dodanie odpowiednich 
klauzul ograniczeñ
*/
CREATE TABLE adresy (
    adres_id  NUMBER(3) NOT NULL,
    ulica     VARCHAR2(15 CHAR) NOT NULL,
    numer     NUMBER(3) NOT NULL,
    miasto    VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE adresy ADD CONSTRAINT adresy_pk PRIMARY KEY ( adres_id );

CREATE TABLE atrakcje (
    atrakcja_id  NUMBER(3) NOT NULL,
    nazwa        VARCHAR2(50) NOT NULL,
    koszt        NUMBER(5, 2) NOT NULL
);

ALTER TABLE atrakcje ADD CONSTRAINT atrakcje_pk PRIMARY KEY ( atrakcja_id );

CREATE TABLE goscie (
    gosc_id         NUMBER(3) NOT NULL,
    imie            VARCHAR2(20 CHAR) NOT NULL,
    nazwisko        VARCHAR2(30 CHAR) NOT NULL,
    plec            VARCHAR2(1 CHAR),
    wiek            NUMBER(10) NOT NULL,
    grupa_id        NUMBER(3) NOT NULL,
    organizator_id  NUMBER(3) NOT NULL
);

ALTER TABLE goscie ADD CONSTRAINT goscie_pk PRIMARY KEY ( gosc_id );

CREATE TABLE grupa_rezerw (
    grupa_rezerw_id  NUMBER(3) NOT NULL,
    grupa_id         NUMBER(3) NOT NULL,
    rezerwacja_id    NUMBER(3) NOT NULL
);

ALTER TABLE grupa_rezerw ADD CONSTRAINT grupa_rezerw_pk PRIMARY KEY ( grupa_rezerw_id );

CREATE TABLE grupy (
    grupa_id        NUMBER(3) NOT NULL,
    organizator_id  NUMBER(3) NOT NULL
);

ALTER TABLE grupy ADD CONSTRAINT grupy_pk PRIMARY KEY ( grupa_id );

CREATE TABLE pietra (
    pietro_id  NUMBER(3) NOT NULL,
    poziom     NUMBER(2) NOT NULL
);

ALTER TABLE pietra ADD CONSTRAINT pietra_pk PRIMARY KEY ( pietro_id );

CREATE TABLE pietro_pokoj (
    pietro_pokoj_id  NUMBER(3) NOT NULL,
    pietra_id        NUMBER(3) NOT NULL,
    pokoj_id         NUMBER(3) NOT NULL
);

ALTER TABLE pietro_pokoj ADD CONSTRAINT pietro_pokoj_pk PRIMARY KEY ( pietro_pokoj_id );

CREATE TABLE pokoje (
    pokoj_id        NUMBER(3) NOT NULL,
    data_renowacji  DATE NOT NULL,
    pojemnosc       NUMBER(2) NOT NULL,
    typ_id          NUMBER(3) NOT NULL,
    status_id       NUMBER(3) NOT NULL
);

ALTER TABLE pokoje ADD CONSTRAINT pokoje_pk PRIMARY KEY ( pokoj_id );

CREATE TABLE pracownicy (
    pracownik_id   NUMBER(3) NOT NULL,
    imie           VARCHAR2(20 CHAR) NOT NULL,
    nazwisko       VARCHAR2(30 CHAR) NOT NULL,
    plec           VARCHAR2(1 CHAR),
    adres_id       NUMBER(3) NOT NULL,
    stanowisko_id  NUMBER(3) NOT NULL,
    pietro_id      NUMBER(3) NOT NULL
);

ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_pk PRIMARY KEY ( pracownik_id );

CREATE TABLE rezerwacje (
    rezerwacja_id  NUMBER(3) NOT NULL,
    przyjazd       DATE NOT NULL,
    wyjazd         DATE NOT NULL,
    koszt          NUMBER(10, 2) NOT NULL,
    pracownik_id   NUMBER(3) NOT NULL,
    znizka_id      NUMBER(3),
    pokoj_id       NUMBER(3) NOT NULL,
    atrakcja_id    NUMBER(3)
);

ALTER TABLE rezerwacje ADD CONSTRAINT rezerwacje_pk PRIMARY KEY ( rezerwacja_id );

CREATE TABLE stanowiska (
    stanowisko_id  NUMBER(3) NOT NULL,
    nazwa          VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE stanowiska ADD CONSTRAINT stanowiska_pk PRIMARY KEY ( stanowisko_id );

CREATE TABLE status (
    status_id  NUMBER(3) NOT NULL,
    nazwa      VARCHAR2(20 CHAR)
);

ALTER TABLE status ADD CONSTRAINT status_pk PRIMARY KEY ( status_id );

CREATE TABLE typy (
    typ_id             NUMBER(3) NOT NULL,
    nazwa              VARCHAR2(10 CHAR) NOT NULL,
    min_cena_na_osobe  NUMBER(6, 2) NOT NULL,
    max_cena_na_osobe  NUMBER(6, 2) NOT NULL
);

ALTER TABLE typy ADD CONSTRAINT typy_pk PRIMARY KEY ( typ_id );

CREATE TABLE znizki (
    znizka_id    NUMBER(3) NOT NULL,
    rozpoczenie  DATE NOT NULL,
    zakonczenie  DATE NOT NULL,
    wartosc      NUMBER(4, 2) NOT NULL,
    nazwa        VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE znizki ADD CONSTRAINT znizki_pk PRIMARY KEY ( znizka_id );

ALTER TABLE goscie
    ADD CONSTRAINT goscie_goscie_fk FOREIGN KEY ( organizator_id )
        REFERENCES goscie ( gosc_id );

ALTER TABLE goscie
    ADD CONSTRAINT goscie_grupy_fk FOREIGN KEY ( grupa_id )
        REFERENCES grupy ( grupa_id );

ALTER TABLE grupa_rezerw
    ADD CONSTRAINT grupa_rezerw_grupy_fk FOREIGN KEY ( grupa_id )
        REFERENCES grupy ( grupa_id );

ALTER TABLE grupa_rezerw
    ADD CONSTRAINT grupa_rezerw_rezerwacje_fk FOREIGN KEY ( rezerwacja_id )
        REFERENCES rezerwacje ( rezerwacja_id );

ALTER TABLE pietro_pokoj
    ADD CONSTRAINT pietro_pokoj_pietra_fk FOREIGN KEY ( pietra_id )
        REFERENCES pietra ( pietro_id );

ALTER TABLE pietro_pokoj
    ADD CONSTRAINT pietro_pokoj_pokoje_fk FOREIGN KEY ( pokoj_id )
        REFERENCES pokoje ( pokoj_id );

ALTER TABLE pokoje
    ADD CONSTRAINT pokoje_status_fk FOREIGN KEY ( status_id )
        REFERENCES status ( status_id );

ALTER TABLE pokoje
    ADD CONSTRAINT pokoje_typy_fk FOREIGN KEY ( typ_id )
        REFERENCES typy ( typ_id );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_adresy_fk FOREIGN KEY ( adres_id )
        REFERENCES adresy ( adres_id );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_pietra_fk FOREIGN KEY ( pietro_id )
        REFERENCES pietra ( pietro_id );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_stanowiska_fk FOREIGN KEY ( stanowisko_id )
        REFERENCES stanowiska ( stanowisko_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_atrakcje_fk FOREIGN KEY ( atrakcja_id )
        REFERENCES atrakcje ( atrakcja_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_pokoje_fk FOREIGN KEY ( pokoj_id )
        REFERENCES pokoje ( pokoj_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_pracownicy_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownicy ( pracownik_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_znizki_fk FOREIGN KEY ( znizka_id )
        REFERENCES znizki ( znizka_id );

CREATE OR REPLACE TRIGGER fkntm_pietro_pokoj BEFORE
    UPDATE OF pokoj_id, pietra_id ON pietro_pokoj
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table Pietro_Pokoj is violated');
END;
/
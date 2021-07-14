import java.io.FileInputStream;
import java.io.*;
import java.sql.*;
import java.util.Random;
import java.util.Scanner;
import java.util.Properties;

import oracle.jdbc.pool.OracleDataSource; //sterownik bazy danych Oracle


public class HotelApp {
    Connection conn; // obiekt Connection do nawiazania polaczenia z baza danych

    public static void main(String[] args) {
        HotelApp app = new HotelApp();

        try{
            app.setConnection();
            //app.pokazGosci();
            //app.pokazGrupeGosci();
            //app.aktualizacjaCenAtrakcji();
            app.kodDostep();
            app.closeConnection();

        }catch (SQLException eSQL){
            System.out.println("Blad przetwarzania SQL " + eSQL.getMessage());
        }catch (IOException eIO) {
            System.out.println("Nie mozna otworzyc pliku" );
        }
    }

    /**
     * Metoda odpowiedzialna za nazwiązywania połączenia
     * @throws SQLException
     * @throws IOException
     */
    public void setConnection() throws SQLException, IOException {

        Properties prop = new Properties();
        FileInputStream in = new FileInputStream("infoConn.properties");
        prop.load(in);
        in.close();

        String host = prop.getProperty("jdbc.host");
        String username = prop.getProperty("jdbc.username");
        String password = prop.getProperty("jdbc.password");
        String port = prop.getProperty("jdbc.port");
        String serviceName = prop.getProperty("jdbc.service.name");

        String connectionString = String.format(
                "jdbc:oracle:thin:%s/%s@//%s:%s/%s",
                username, password, host, port, serviceName);

        System.out.println (connectionString);
        OracleDataSource ods; // nowe zrodlo danych (klasa z drivera  Oracle)
        ods = new OracleDataSource();

        ods.setURL(connectionString);
        conn = ods.getConnection(); // nawiazujemy polaczenie z BD

        DatabaseMetaData meta = conn.getMetaData();

        System.out.println("Polaczenie do bazy danych nawiazane.");
        System.out.println("Baza danych:" + " " + meta.getDatabaseProductVersion());
    }

    /**
     * Metoda do zamknięcia połączenia
     * @throws SQLException
     */
    public void closeConnection() throws SQLException {
        conn.close();
        System.out.println("Polaczenie z baza zamkniete poprawnie.");
    }

    /**
     * Metoda umożliwiająca odczytanie całej listy gości w hotelu
     * @throws SQLException
     */
    public void pokazGosci() throws  SQLException {
        System.out.println("Lista gości:");

        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery("SELECT imie, nazwisko FROM goscie ");

        System.out.println("---------------------------------");
        while (rs.next())
            System.out.println(rs.getString(1) + " " + rs.getString(2));
        System.out.println("---------------------------------");

        rs.close();
        stat.close();
    }

    /**
     * Metoda umożliwiająca pokazanie gości z danej grupy
     * @throws SQLException
     */
    public void pokazGrupeGosci() throws  SQLException {

        PreparedStatement preparedStatement = conn
                .prepareStatement("SELECT g.imie, g.nazwisko FROM goscie g JOIN grupy gr USING (organizator_id)" +
                        "WHERE gr.grupa_id = ?");

        System.out.println("Podaj numer grupy (indeksy zaczynają się od 501):");

        Scanner in = new Scanner(System.in);

        preparedStatement.setString(1, in.nextLine());
        ResultSet rs = preparedStatement.executeQuery(); // Wykonaj zapytanie oraz zapamietaj zbior rezultatow

        System.out.println("---------------------------------");
        while (rs.next()) {
            System.out.println(rs.getString(1) + " " + rs.getString(2));		}
        System.out.println("---------------------------------");

        rs.close();
        preparedStatement.close();
    }

    /**
     * Metoda służąca akyualzacji cen atrkacji hotelowych, które zaczynaja się na K
     * @throws SQLException
     */
    public void aktualizacjaCenAtrakcji() throws SQLException{
        System.out.println("Aktualizacja cen atrakcji hotelowych");

        try{
            conn.setAutoCommit(false);

            Statement stat = conn.createStatement();
            int rsInt = stat.executeUpdate("UPDATE atrakcje SET koszt = koszt + 50 WHERE nazwa LIKE 'K%'");
            System.out.println("Aktualizacja dotyczyła: " + rsInt + " wierszy");

            conn.commit();
            stat.close();
        }catch (SQLException eSQL) {
            System.out.println("Transakcja wycofana");
            conn.rollback();
        }
    }

    /**
     * Metoda wywołująca funkcję kod_dostepu
     * @throws SQLException
     */
    public void kodDostep() throws  SQLException {
        System.out.println("Kody dostępu");

        CallableStatement callFunction = conn.prepareCall("{? = call kod_dostepu(?)}");
        callFunction.registerOutParameter(1, Types.VARCHAR);

        Random ran = new Random();
        int min = 701;
        int max = 730;
        int numInterations = 5;

        for (int i = 0; i < numInterations; i++) {
            int id = ran.nextInt(max - min) + min;
            callFunction.setInt(2, id);
            callFunction.execute();
            String bonus = callFunction.getString(1);
            System.out.println("Pracownik " + id + " ma kod dostępu " + bonus);
        }
        callFunction.close();
    }
}
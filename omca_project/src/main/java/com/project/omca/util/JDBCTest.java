package com.project.omca.util;

import java.sql.Connection;

import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {

		try {
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "icia",
					"1111");
			System.out.println(con);
			System.out.println("접속성공");
		} catch (Exception e) {
			e.getMessage();
			System.out.println("접속실패");
		}

	}

}

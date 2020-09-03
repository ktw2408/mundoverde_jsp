package mundo_verde;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import jsp.common.util.DBConnection;

public class Board 
{
	String     m_DBMS     = "jdbc:mysql://127.0.0.1/mundo_verde?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	Connection        m_Connection;
	PreparedStatement m_SelectStatment;
	ResultSet         m_ResultSet;	
		
	public String getVersion()
	{
		return "Java Beans Board v1.0";
	}
	
		//MySQL 연결을 위한 라이브러리를 로딩한다.
	protected boolean LoadDriver() 
	{		
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch(Exception e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//MySQL에 접속한다.
	public boolean DBOpen()
	{
		if(LoadDriver() == false)
		{
			return false;
		}
		try
		{
			m_Connection = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//MySQL 접속을 종료한다.
	public void DBClose()
	{
		try
		{
			m_Connection.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return;
		}		
	}
	
	//Query를 수행한다.
	public boolean OpenQuery(String pSQL)
	{
		try
		{
			m_SelectStatment= m_Connection.prepareStatement(pSQL,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			m_ResultSet = m_SelectStatment.executeQuery();		
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}			
		return true;
	}
	
	//Query를 종료한다.
	public void CloseQuery()
	{
		try
		{		
			//검색된 결과를 닫는다.
			m_ResultSet.close();
	
			//stmt 를 닫는다.
			m_SelectStatment.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return;
		}				
	}
	
	//다음 레코드로 이동한다.
	public boolean ResultNext()
	{
		try
		{		
			return m_ResultSet.next();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}		
	}
	
	//레코드의 값을 얻는다.
	public String getString(String pName)
	{
		try
		{		
			return m_ResultSet.getString(pName);
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}			
	}
	
	//레코드의 값을 얻는다.
	public int getInt(String pName)
	{
		try
		{		
			return Integer.parseInt(m_ResultSet.getString(pName));
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}			
	}	
	
	//Insert, Delete, Update 처리용 함수
	public boolean Excute(String pSQL)
	{
		PreparedStatement mStmt;
		
		try
		{		
			mStmt  = m_Connection.prepareStatement(pSQL,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			mStmt.executeUpdate();
			//stmt 를 닫는다.
			mStmt.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}			
		return true;
	}
	
	public static void main(String[] args) 
	{
		// TODO Auto-generated method stub

	}

}

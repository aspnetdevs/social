using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;


public static class Helper
{
    public static string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    public static DataTable FindMessages(string senderId, string receiverId)
    {
        return SqlQuery(@"SELECT r.first_name as receiver_first_name, 
	                      r.last_name as receiver_last_name,
	                      r.status as receiver_status,
	                      s.first_name as sender_first_name, 
	                      s.last_name as  sender_last_name, 
	                      s.status as sender_status,
	                      s.message_id,
	                      s.message,
	                      s.dispatch_date
                   FROM persons r 
                        INNER JOIN (SELECT * FROM persons p 
					                              INNER JOIN(SELECT * FROM messages 
								                             WHERE ("+senderId+@" = 2 OR "+senderId+@" = 1) AND 
									                               ("+receiverId+@" = 1 OR "+receiverId+@" = 2)) m 
					                              ON p.id = m.sender_id) s 
                        ON r.id = s.receiver_id");
    }

    public static DataTable SqlQuery(string query)
    {
        SqlConnection conn = new SqlConnection(connString);
        DataTable dt = new DataTable();
        SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
        conn.Open();
        adapter.Fill(dt);
        conn.Close();
        return dt;
    }
}
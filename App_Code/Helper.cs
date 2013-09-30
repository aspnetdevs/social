using System;
using System.Collections;
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
        return SqlQuery(@"SELECT id,first_name,last_name, status,message_id,message,dispatch_date 
                          FROM persons p INNER JOIN( SELECT * FROM messages 
								                              WHERE ((sender_id = "+senderId+@" AND sender_delete = 0) AND 
                                                                    (receiver_id = "+receiverId+@") OR (sender_id = "+receiverId+@") AND 
                                                                    (receiver_id = "+senderId+@" AND receiver_delete = 0)
)) m 
					                              ON p.id = m.sender_id");
    }

    public static DataTable SqlQuery(string query)
    {
        SqlConnection conn = new SqlConnection(connString);
        SqlCommand cmd = new SqlCommand();
        DataTable dt = new DataTable();
        SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
        conn.Open();
        adapter.Fill(dt);
        conn.Close();
        return dt;
    }

    public static int SqlUpdateData(string query, IDictionary<string,object> parameters)
    {
        SqlConnection conn = new SqlConnection(connString);
        SqlCommand cmd = new SqlCommand(query,conn);
        foreach (var parameter in parameters)
        {
            cmd.Parameters.AddWithValue(parameter.Key, parameter.Value);
        }
        conn.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        conn.Close();
        return rowsAffected;
    }
}
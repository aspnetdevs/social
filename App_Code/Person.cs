using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

public class Person
{
    public DataRow Fields { get; set; }
    public DataTable Friends { get; set; }

    public Person(string id)
    {
        if (!String.IsNullOrEmpty(id))
        {
            Fields = Helper.SqlQuery("SELECT * FROM persons WHERE id=" + id).Rows[0];
        }
    }

    public Person FindFriends(string partName)
    {
        Friends = Helper.SqlQuery(@"SELECT * FROM persons WHERE id IN (SELECT friend_id FROM persons_to_friends WHERE person_id = " + Fields["id"] + ") AND (first_name+' '+last_name LIKE '%" + partName + "%')");
        return this;
    }
    public Person FindFriendsOnline(string partName)
    {
        Friends = Helper.SqlQuery(@"SELECT * FROM persons WHERE id IN (SELECT friend_id FROM persons_to_friends WHERE person_id = " + Fields["id"] + ") AND (status='Online')");
        return this;
    }
}

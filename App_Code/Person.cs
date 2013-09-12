using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Social
{
    public class Person
    {
        //only some properties. To add another
        public string ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthday { get; set; }
        public string Mobile { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string Status { get; set; }
        public List<Person> Friends { get; set; }
        public string AvatarUrl { get; set; }

        SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;

        //May be there isn't need for Person Class.
        public Person(string id)
        {
            if (!String.IsNullOrEmpty(id))
            {
                conn = new SqlConnection(connString);
                //To check id string for security
                DataTable dt = new DataTable("persons");
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM persons WHERE id=" + id, conn);
                conn.Open();
                adapter.Fill(dt);
                conn.Close();
                SetProps(dt.Rows[0]);
            }
        }

        public Person(DataRow row)
        {
            SetProps(row);
        }

        private void SetProps(DataRow dr)
        {
            if (dr != null)
            {
                ID = dr["id"].ToString();
                FirstName = dr["first_name"].ToString();
                LastName = dr["last_name"].ToString();
                Birthday = (DateTime)dr["birthday"];
                Mobile = dr["mobile"].ToString();
                Address = dr["address"].ToString();
                Email = dr["email"].ToString();
                Status = dr["status"].ToString();
                AvatarUrl = dr["avatar"].ToString();
            }
        }
        //May be it's better to query only needed columns
        public Person FindFriends() 
        {
            if (ID != null)
            {
                SqlConnection conn = new SqlConnection(connString);
                DataTable dt = new DataTable("friends");
                SqlDataAdapter adapter = new SqlDataAdapter(@"SELECT * FROM persons
                                                          WHERE id IN (SELECT friend_id FROM persons_to_friends WHERE person_id = " + ID + ")", conn);
                conn.Open();
                adapter.Fill(dt);
                conn.Close();
                Friends = new List<Person>();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Friends.Add(new Person(dt.Rows[i]));
                }
            }
            return this;

        }
    }
}
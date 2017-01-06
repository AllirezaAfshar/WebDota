using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;

namespace WebDota.Domain
{
    public class SqlHelper
    {
        /// <summary>
        /// یک پرس و جوی ساده را در پایگاه داده اجرا می کند
        /// </summary>
        /// <param name="query"></param>
        public static void Run(string query)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                command.ExecuteScalar();

                connection.Close();
            }
        }
        /// <summary>
        /// یک پرس و جوی ساده را در پایگاه داده اجرا می کند
        /// </summary>
        /// <param name="query"></param>
        public static object RunWithReturnValue(string query)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                object retObj;
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteScalar();

                connection.Close();
                return retObj;
            }
        }


        /// <summary>
        /// یک پرس و جوی ساده را در پایگاه داده اجرا می کند
        /// </summary>
        /// <param name="query"></param>
        public static List<string> RunWithColomnIasString(string query, int i)
        {
            List<string> retList = new List<string>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();

                if (retObj.HasRows)
                {
                    while (retObj.Read())
                    {
                        retList.Add(retObj.GetString(i));
                        //retObj.NextResult();
                    }
                }
                connection.Close();
            }
            return retList;
        }


        public static WebDota.User GetUser(string email)
        {
            WebDota.User ret = new User();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"select top 1 u.Name , upp.PlayerID , pch.HeroID , h.Name , u.Email from [User] as u
                    , PlayerControlHero as pch,
                    UserPlayPlayer as upp , Hero as h
                    where Email like '" + email+@"%'
                    and upp.UserID = u.ID and pch.PlayerID = upp.PlayerID and h.ID = pch.HeroID
                    order by u.ID desc";
                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();

                if (retObj.HasRows)
                {
                    retObj.Read();
                    {
                        ret.Name = retObj.GetString(0).Trim();
                        ret.PlayerID = retObj.GetInt32(1).ToString();
                        ret.HeroID = retObj.GetInt32(2).ToString();
                        ret.HeroName = retObj.GetString(3).Trim();
                        ret.Email = retObj.GetString(4).Trim();
                    }
                }
                else
                {
                    connection.Close();
                    return null;
                }
                connection.Close();
            }
            return ret;
        }


        public static List<User> GetOtherUser(string email)
        {
            List<User> retList = new List<User>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"select  u.Name , upp.PlayerID , pch.HeroID , h.Name , u.Email from [User] as u
                    , PlayerControlHero as pch,
                    UserPlayPlayer as upp , Hero as h
                    where Email not like '" + email + @"%'
                    and upp.UserID = u.ID and pch.PlayerID = upp.PlayerID and h.ID = pch.HeroID
                    ";
                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();

                if (retObj.HasRows)
                {
                    while(retObj.Read())
                    {
                        User u = new User();
                        u.Name = retObj.GetString(0).Trim();
                        u.PlayerID = retObj.GetInt32(1).ToString();
                        u.HeroID = retObj.GetInt32(2).ToString();
                        u.HeroName = retObj.GetString(3).Trim();
                        u.Email = retObj.GetString(4).Trim();
                        retList.Add(u);
                    }
                }
                else
                {
                    connection.Close();
                    return null;
                }
                connection.Close();
            }
            return retList;
        }



        public static List<Item> GetItems()
        {
            List<Item> retList = new List<Item>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"SELECT TOP (1000) [ID]
      ,[name]
  FROM [WebDota].[dbo].[Items]
                    ";
                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();

                if (retObj.HasRows)
                {
                    while (retObj.Read())
                    {
                        Item i = new Item();
                        i.ID = retObj.GetInt32(0).ToString();
                        i.Name = retObj.GetString(1).Trim();
                        retList.Add(i);
                    }
                }
                else
                {
                    connection.Close();
                    return null;
                }
                connection.Close();
            }
            return retList;
        }
        public static List<List<string>> RunWithColomns(string query)
        {
            List<List<string>> retList = new List<List<string>>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();

                if (retObj.HasRows)
                {
                    while (retObj.Read())
                    {
                        List<string> tmp = new List<string>();
                        for (int i = 0; i < retObj.FieldCount; i++)
                        {
                            tmp.Add(retObj.GetString(i));
                        }
                        retList.Add(tmp);

                        //retObj.NextResult();
                    }
                }



                connection.Close();

            }
            return retList;
        }

        /// <summary>
        /// یک پرس و جو را اجرا کرده و مقادیر مربوط به آن را بازگردانی می کند.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <returns></returns>
        public static T GetValue<T>(string query) where T : struct
        {
            return GetValue<T>(query, null);
        }

        public static T GetValue<T>(string query, SqlParameter[] parameters)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                if (parameters != null)
                {
                    if (parameters.Length != 0)
                    {
                        command.Parameters.AddRange(parameters);
                    }
                }
                T res = (T)command.ExecuteScalar();

                connection.Close();

                return res;
            }
        }

        public static int Count(string query)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };

                var res = command.ExecuteScalar();
                int count = Convert.ToInt32(res);

                connection.Close();
                return count;
            }
        }

        /// <summary>
        /// بررسی می کند که آیا جدول با نام مشخص شده وجود دارد یا خیر
        /// </summary>
        /// <param name="tableName"> نام جدولی که قرار است وجود یا عدم وجود آن بررسی شود </param>
        /// <returns></returns>
        /// <remarks>
        /// این تابع در هیچ صورتی نبایستی استثناء مدیریت نشده ای پرتاب کند
        /// </remarks>
        public static bool IsTableExistance(string tableName)
        {
            try
            {
                int tableCount =
                    GetValue<Int32>(
                        "SELECT COUNT(*) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [INFORMATION_SCHEMA].[TABLES].[TABLE_NAME] LIKE @table_name",
                        new SqlParameter[] { new SqlParameter("@table_name", SqlDbType.NVarChar) { Value = tableName } });
                if (tableCount == 1)
                {
                    return true;
                }
            }
            catch (Exception)
            {
                // DO Nothing
            }
            return false;
        }

        public static bool IsColumnExist(string tableName, string columnName)
        {
            try
            {
                int tableCount =
                    GetValue<Int32>(
                        @"SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS INNER JOIN INFORMATION_SCHEMA.TABLES ON INFORMATION_SCHEMA.COLUMNS.TABLE_NAME = INFORMATION_SCHEMA.TABLES.TABLE_NAME
                            WHERE INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME LIKE @column_name AND INFORMATION_SCHEMA.TABLES.TABLE_NAME LIKE @table_name",
                        new SqlParameter[]
                        {
                            new SqlParameter("@table_name", SqlDbType.NVarChar) { Value = tableName },
                            new SqlParameter("@column_name", SqlDbType.NVarChar) {Value = columnName},
                        });
                if (tableCount == 1)
                {
                    return true;
                }
            }
            catch (Exception)
            {
                // DO Nothing
            }
            return false;
        }

    }
}
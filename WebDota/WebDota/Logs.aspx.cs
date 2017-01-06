using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDota
{
    public partial class Logs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            using (
                SqlConnection connection =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"	SELECT TOP (1000) [TargetID]
		  ,[ActorID]
		  ,[Spell]
		  ,[ID]
		  ,[createdAt]
		  ,[mark]
	  FROM [WebDota].[dbo].[MagicLogs]";
                SqlCommand command = new SqlCommand(query, connection) {CommandTimeout = 0};
                retObj = command.ExecuteReader();
                MagicLog.DataSource = retObj;
                MagicLog.DataBind();

            }

            using (
    SqlConnection connection =
        new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ActorID]
      ,[TargetID]
      ,[AttackAmount]
      ,[ID]
      ,[AttackRecieved]
      ,[createdAt]
      ,[mark]
  FROM [WebDota].[dbo].[AttackLog]";
                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();
                AttackLog.DataSource = retObj;
                AttackLog.DataBind();

            }

        }
        }
}
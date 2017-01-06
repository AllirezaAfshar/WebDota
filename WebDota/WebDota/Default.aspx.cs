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
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserSession.User == null)
            {
                Response.Redirect("Account/Login.aspx");
            }
            using (
    SqlConnection connection =
        new SqlConnection(ConfigurationManager.ConnectionStrings["WarehouseContext"].ConnectionString))
            {
                SqlDataReader retObj;
                connection.Open();
                string query = @"SELECT TOP (1000) [KS]
      ,[Death]
      ,[CurrentMana]
      ,[Kill]
      ,[Assint]
      ,[CurrentHP]
      ,[Exprience]
      ,[BonusIntl]
      ,[BonusAgl]
      ,[BonusStr]
      ,[ID]
      ,[Gold]
      ,[Turn]
      ,[Bounce]
      ,[Terror]
  FROM [WebDota].[dbo].[Player] where ID = "+ UserSession.User.PlayerID.ToString() + "";
                SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = 0 };
                retObj = command.ExecuteReader();
                info.DataSource = retObj;
                info.DataBind();

            }
        }
    }
}
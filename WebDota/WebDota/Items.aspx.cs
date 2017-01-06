using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDota.Domain;

namespace WebDota
{
    public partial class Items : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserSession.User == null)
            {
                Response.Redirect("Account/Login.aspx");
            }
            ItemsGrid.DataSource = SqlHelper.GetItems();
            ItemsGrid.DataBind();
        }

        protected void Sell_Click(object sender, EventArgs e)
        {
            SqlHelper.Run(@"
                    DECLARE @RC int
                    EXECUTE @RC = [dbo].[SellItem]
                   " + 2 + @"
                  , '" + txtItemName.Text+"'");
        }

        protected void Buy_Click(object sender, EventArgs e)
        {
            SqlHelper.Run(@"
                    DECLARE @RC int
                    EXECUTE @RC = [dbo].[BuyItem]
                   " + 2 + @"
                  , '" + txtItemName.Text+"'");
        }
    }
}
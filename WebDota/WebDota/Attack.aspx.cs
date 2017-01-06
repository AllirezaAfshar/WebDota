using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDota.Domain;

namespace WebDota
{
    public partial class Attack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserSession.User == null)
            {
                Response.Redirect("Account/Login.aspx");
            }
            otherUserGrid.DataSource = SqlHelper.GetOtherUser(UserSession.User.Email);
            otherUserGrid.DataBind();
        }

        protected void btnAttack_Click(object sender, EventArgs e)
        {
            try
            {
                SqlHelper.Run(@"
                    DECLARE @RC int
                    EXECUTE @RC = [dbo].[Attack] 
                   " + 2 + @"
                  , " + txtPlayerId.Text);
            }
            catch (Exception exp)
            {

                result.Text = exp.Message;
            }
            result.Text = "Done";

        }
    }
}
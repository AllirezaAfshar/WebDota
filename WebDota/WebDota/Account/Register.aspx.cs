using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using WebDota.Models;
using WebDota.Domain;

namespace WebDota.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            try
            {
                SqlHelper.Run(string.Format(@"
                    

                    INSERT INTO[dbo].[User]
                               ([Age]
                               ,[Name]
                               ,[UserName]
                               ,[Password]
                               ,[Email],
                               ID)
                         VALUES
                               (20,
                               '"+Name.Text + @"',
                               '" + LastName.Text + @"',
                               '" + Password.Text + @"',
                               '" + Email.Text + @"',
                               (SELECT 1 + count(*) from dbo.[User]))
                    
                    "));
                ErrorMessage.Text = "Done";
            }
            catch (Exception exp)
            {
                ErrorMessage.Text = exp.Message;

            }

        }
    }
}
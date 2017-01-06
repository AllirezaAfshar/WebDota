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
                SqlHelper.Run(@"INSERT INTO [dbo].[Player]
                   ([KS]
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
                   ,[Terror])
             VALUES
                   (0
                   ,0
                   ,2000
                   ,0
                   ,0
                   ,1500
                   ,0
                   ,0
                   ,0
                   ,0
                   ,(SELECT 1 + count(*) from dbo.Player)
                   ,2000
                   ,200
                   ,0
                   ,0)");
                SqlHelper.Run(@"INSERT INTO [dbo].[UserPlayPlayer]
                   ([PlayerID]
                   ,[UserID]
                   ,[ID])
             VALUES
                   ((SELECT  count(*) from dbo.Player)
                   ,(SELECT  count(*) from dbo.[User])
                   ,(SELECT 1 + count(*) from dbo.UserPlayPlayer))");
                SqlHelper.Run(@"INSERT INTO [dbo].[PlayerControlHero]
                   ([HeroID]
                   ,[PlayerID]
                   ,[ID])
             VALUES
                   ("+txtHeroId.Text+@"
                   ,(SELECT  count(*) from dbo.Player)
                   ,(SELECT 1+ count(*) from dbo.PlayerControlHero))");
                ErrorMessage.Text = "Done";
                UserSession.User = SqlHelper.GetUser(Email.Text);

            }
            catch (Exception exp)
            {
                ErrorMessage.Text = exp.Message;

            }

        }
    }
}
USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [WebDotaLogin]    Script Date: 1/4/2017 4:53:29 PM ******/
CREATE LOGIN [WebDotaLogin] WITH PASSWORD=N'cYLyd4fax889azZ/wcZPTQWqNB81aw/5aGQw8nnvptk=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [WebDotaLogin] DISABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [WebDotaLogin]
GO



USE [SIMS]
GO

/****** Object:  Table [dbo].[registeredCourses]    Script Date: 4/14/2017 11:38:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[registeredCourses](
	[studentId] [int] NOT NULL,
	[courseId] [int] NOT NULL,
	[exam1] [int] NULL,
	[semester] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[studentId] ASC,
	[courseId] ASC,
	[semester] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[registeredCourses]  WITH CHECK ADD  CONSTRAINT [FK_registeredCourses_courseId] FOREIGN KEY([courseId])
REFERENCES [dbo].[courses] ([courseId])
GO

ALTER TABLE [dbo].[registeredCourses] CHECK CONSTRAINT [FK_registeredCourses_courseId]
GO

ALTER TABLE [dbo].[registeredCourses]  WITH CHECK ADD  CONSTRAINT [FK_registeredCourses_studentId] FOREIGN KEY([studentId])
REFERENCES [dbo].[students] ([studentId])
GO

ALTER TABLE [dbo].[registeredCourses] CHECK CONSTRAINT [FK_registeredCourses_studentId]
GO


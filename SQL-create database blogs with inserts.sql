SET NOCOUNT ON 

USE Master 
GO 

IF  EXISTS (SELECT * FROM sys.databases WHERE name = N'blogs') DROP DATABASE [blogs]
GO 

CREATE DATABASE [blogs]
GO 

USE [blogs]
GO

CREATE TABLE Users
(
    user_id int identity(1,1) primary key,
    first_name nvarchar(50) NOT NULL,   
    last_name nvarchar(50) NOT NULL, 
    user_name nvarchar(25) NOT NULL UNIQUE ,
    user_password int NOT NULL check(len(user_password) >= 8 ),
    email varchar(100) NOT NULL UNIQUE check(email like '%@%')
)


CREATE TABLE PhonePass 
(
	phone_id integer identity(1,1) CONSTRAINT php_pid_pk  primary key,
	user_id integer CONSTRAINT php_uid_fk_nn references Users(user_id) not null,
	phone nvarchar(20) CONSTRAINT  php_ph_nn not null,
	is_main BIT CONSTRAINT php_ism_nn not null
)


CREATE TABLE Permission
(
	perm_id int IDENTITY(1,1) PRIMARY KEY,
	perm_type nvarchar(20) NOT NULL UNIQUE,
	is_read bit NOT NULL DEFAULT(0),
	is_create bit NOT NULL DEFAULT(0),
	is_write bit NOT NULL DEFAULT(0),
	is_category bit NOT NULL DEFAULT(0),
	is_create_users bit NOT NULL,
	is_block_users bit NOT NULL DEFAULT(0),
)


CREATE TABLE User_Perms 
(
	user_id int NOT NULL REFERENCES Users(user_id),
	perm_id int NOT NULL REFERENCES Permission(perm_id),
	perm_date datetime NOT NULL DEFAULT(GETDATE()) check(perm_date >= GETDATE()),
	CONSTRAINT [PK_USER_PREMS] PRIMARY KEY(user_id, perm_date) 
)


CREATE TABLE Subscriptions
(
	sub_id integer identity(1,1) CONSTRAINT sub_id_pk  primary key,
	sub_type nvarchar(20) CONSTRAINT sub_ty_nq_nn unique not null
)


CREATE TABLE User_Subs 
(
	 user_id integer CONSTRAINT usub_uid_fk_nn references Users(user_id) not null,
	 sub_id  integer CONSTRAINT usub_sid_fk_nn references Subscriptions(sub_id) not null,
	 sub_date datetime CONSTRAINT usub_dat_n DEFAULT(GETDATE()) not null,  -- check(sub_date >= GETDATE()),
	 CONSTRAINT [USUB_PK_USER_SUB] PRIMARY KEY(user_id, sub_date)
)

CREATE TABLE SubscriberPrice
(
	sub_id int not null references Subscriptions(sub_id) ,
	price money not null check(price > 0 ) ,
	startDate datetime DEFAULT(GETDATE()) not null  ,
	endDate datetime  not null ,
--	CONSTRAINT  valid_date check(endDate > startDate )
)

CREATE TABLE Posts 
(
	post_id int IDENTITY(1,1) PRIMARY KEY,
	user_id int NOT NULL REFERENCES Users(user_id),
	post_title nvarchar (25) NOT NULL,
	post_description nvarchar(100) not null,
	post_url  nvarchar(100) NOT NULL unique,
	post_date datetime DEFAULT(GETDATE()) NOT NULL,
	post_likes int DEFAULT(0) check(post_likes >= 0),  	
	post_disslike int DEFAULT(0) check(post_disslike >= 0) ,
)


CREATE TABLE Comments 
(
	comment_id int IDENTITY(1,1) PRIMARY KEY,
	post_id int NOT NULL REFERENCES Posts(post_id),
	user_id int NOT NULL REFERENCES Users(user_id),
	parent_id int,
	comment_date datetime DEFAULT(GETDATE()) NOT NULL,
	comment_content nvarchar(100) NOT NULL,
	comment_likes int DEFAULT(0) check(comment_likes >= 0) ,
	comment_dislikes int DEFAULT(0) check(comment_dislikes >= 0) ,
)


insert into Users(first_name, last_name,user_name,user_password, email) values('Eudora','LArcher','elarcher0',12345678, 'elarcher0@sciencedaily.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Whitman','Jemmison','wjemmison1',23456788,'wjemmison1@alexa.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Vera','Allworthy','vallworthy2',33456679,'vallworthy2@mit.edu')
insert into Users(first_name, last_name,user_name,user_password, email) values('Hubey','Petroselli','hpetroselli3',45675890,'hpetroselli3@cam.ac.uk')
insert into Users(first_name, last_name,user_name,user_password, email) values('Idelle','Bentham','ibentham4',98746544,'ibentham4@vimeo.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Colman','Huc','chuc5',56754757,'chuc5@thetimes.co.uk')
insert into Users(first_name, last_name,user_name,user_password, email) values('Stefan','Spybey','sspy4bey6',87187879,'sspybey6@chronoengine.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Johnathon','Rump','jrump7',68376965,'jrump7@amazon.de')
insert into Users(first_name, last_name,user_name,user_password, email) values('Arlina','Penny','apenny8',56274432,'apenny8@bigcartel.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Orion','Ivanishchev','oivanishchev9',22757668,'oivanishchev9@wufoo.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Reeva','Thow','rthowa',29985087,'rthowa@kickstarter.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Ariana','Skells','askellsb',56775438,'askellsb@icq.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Jehu','Attwool','jattwoolc',90198866,'jattwoolc@go.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Debi','Laurenz','dlaurenzd',18579976,'dlaurenzd@berkeley.edu')
insert into Users(first_name, last_name,user_name,user_password, email) values('Junie','Wands','jwandse',13555556,'jwandse@tinyurl.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Roxine','Nibley','rnibleyf',98765434,'rnibleyf@yahoo.co.jp')
insert into Users(first_name, last_name,user_name,user_password, email) values('Etti','Shallcroff','eshallcroffg',12387644,'eshallcroffg@naver.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Allard','Cleaves','acleavesh',87981254,'acleavesh@wp.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Kingsly','McLay','kmclayi',12980765,'kmclayi@prweb.com')
insert into Users(first_name, last_name,user_name,user_password, email) values('Analise','MacAlpine','amacalpinej',19806469,'amacalpinej@last.fm')


-----------------------------------
insert into phonepass(phone,user_id,is_main) values('(805) 8847630',1,7)
insert into phonepass(phone,user_id,is_main) values('(215) 1488970',2,1)
insert into phonepass(phone,user_id,is_main) values('(994) 7083166',3,1)
insert into phonepass(phone,user_id,is_main) values('(934) 4074747',4,1)
insert into phonepass(phone,user_id,is_main) values('(206) 6112147',5,0)
insert into phonepass(phone,user_id,is_main) values('(444) 3755030',6,1)
insert into phonepass(phone,user_id,is_main) values('(787) 1637638',7,0)
insert into phonepass(phone,user_id,is_main) values('(600) 1281649',8,0)
insert into phonepass(phone,user_id,is_main) values('(603) 5442782',9,0)
insert into phonepass(phone,user_id,is_main) values('(942) 7878952',10,1)
insert into phonepass(phone,user_id,is_main) values('(965) 6116003',11,0)
insert into phonepass(phone,user_id,is_main) values('(863) 2606659',12,1)
insert into phonepass(phone,user_id,is_main) values('(573) 6108264',13,1)
insert into phonepass(phone,user_id,is_main) values('(720) 5737678',14,1)
insert into phonepass(phone,user_id,is_main) values('(547) 6051856',15,1)
insert into phonepass(phone,user_id,is_main) values('(514) 9893961',16,0)
insert into phonepass(phone,user_id,is_main) values('(110) 3697429',17,0)
insert into phonepass(phone,user_id,is_main) values('(968) 2590072',18,0)
insert into phonepass(phone,user_id,is_main) values('(110) 3655529',19,0)
insert into phonepass(phone,user_id,is_main) values('(968) 2598072',20,0)
insert into phonepass(phone,user_id,is_main) values('(206) 6992147',5,1)
insert into phonepass(phone,user_id,is_main) values('(787) 1631238',7,1)
insert into phonepass(phone,user_id,is_main) values('(600) 1223649',8,1)
insert into phonepass(phone,user_id,is_main) values('(603) 5782782',9,1)
insert into phonepass(phone,user_id,is_main) values('(965) 6986003',11,1)
insert into phonepass(phone,user_id,is_main) values('(514) 9800961',16,1)
insert into phonepass(phone,user_id,is_main) values('(110) 3611429',17,1)
insert into phonepass(phone,user_id,is_main) values('(968) 2522072',18,1)
insert into phonepass(phone,user_id,is_main) values('(110) 3656529',19,1)
insert into phonepass(phone,user_id,is_main) values('(968) 2567072',20,1)

--------------------------

insert into Permission(perm_type, is_read, is_create, is_write, is_category, is_create_users, is_block_users) values('regular user', 1,0,0,0,0,0) 
insert into Permission(perm_type, is_read, is_create, is_write, is_category, is_create_users, is_block_users) values('donates', 1,1,1,0,0,0)
insert into Permission(perm_type, is_read, is_create, is_write, is_category, is_create_users, is_block_users) values('writer', 1,1,1,1,0,0)
insert into Permission(perm_type, is_read, is_create, is_write, is_category, is_create_users, is_block_users) values('manager', 1,1,1,1,1,1)

--------------------------
insert into User_Perms(user_id,perm_id,perm_date) values(1,1,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(2,2,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(3,2,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(4,2,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(5,3,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(6,3,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(7,3,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(8,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(9,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(10,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(11,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(12,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(13,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(14,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(15,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(16,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(17,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(18,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(19,4,getdate())
insert into User_Perms(user_id,perm_id,perm_date) values(20,4,getdate())

-------------------------------

insert into Subscriptions(sub_type) values('No Subscribed')
insert into Subscriptions(sub_type) values('Regular')
insert into Subscriptions(sub_type) values('Gold')
insert into Subscriptions(sub_type) values('PLATINUM')


--------------------------

insert into User_Subs(user_id,sub_id,sub_date) values (8 , 4 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (9 , 4 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (10 , 4 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (11, 4 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (12 , 1 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (13 , 1 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (14 , 1 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (15 , 1 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (16 , 1 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (17 , 3 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (18 , 3 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (19 , 3 , getdate() )
insert into User_Subs(user_id,sub_id,sub_date) values (20 , 3 , getdate() )


-------------------------------

insert into SubscriberPrice(sub_id, price , startDate , endDate) values(2, 10 , '2021-07-01',  '2021-12-31'  )
insert into SubscriberPrice(sub_id, price , startDate , endDate) values(3, 20 , '2021-07-01', '2021-12-31' )
insert into SubscriberPrice(sub_id, price , startDate , endDate) values(4, 30 , '2021-07-01' , '2021-12-31' )
insert into SubscriberPrice(sub_id, price , startDate , endDate) values(2, 15 , '2022-01-01', '2022-06-30' )
insert into SubscriberPrice(sub_id, price , startDate , endDate) values(3, 25 , '2022-01-01' ,' 2022-06-30'  )
insert into SubscriberPrice(sub_id, price , startDate , endDate) values(4, 37 , '2022-01-01',  '2022-06-30'  )

-------------------------------
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(5, 'Harry only make use time', 'If this is a legitimate option for saving people, why dont they ever use it again?' ,'https://?pharetra=mauris&magna=non&vestii=congue&sapien=vivamus&sapien=&non=aenean&quam' , '2021-01-01', 5,10)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(2, 'Why the Sense self-aware?',	'How do the differences between Deckard and the replicants.tarts off  emotionless as the replicants.', 'http://?consectetuer=mecenas&dmain=jljlj&jkj', '2021-01-02', 54, 7 )
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(2, 'name who eating stuff?', 'was released only very recently. But every now and then scenes set backstage at the Muppet Theatre' ,	'http://?montes=est&nasceur=et&ridiculus=tempus&mus=semper&vivamus=est&vestibulum=quam&sagittisus&', '2021-01-02', 4,10)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(4, 'difference between houses',	'replicant detection occurs via the subjects ability inability to show advanced emotion.', 'http://?scelerisque=magnis&mauri=dis&sit=parturient&amet=montes&eros=nascet&duis==end=cras&=vul', '2021-01-01', 5,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(7, 'What origin of Persephone',	'As shown in the movie Persephone was the wife of The Merovingian,who himself was an obsolete program'	,'https://?donec=prtium&odio=nisl&justo=ut&sollicitudin=volutpat&ut=sapien&suscipit=arcu&a=pat&acium', '2021-01-01', 23,5)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(7, 'How is ending Collateral?',	'Heres what happens at the end of Should we accept this as a', 'http://?tristique=nisl&est=nunc&et=nisl&tempus=duis&semperbibendum&est=felis&quammassa&inlum&nu', '2021-01-01', 6,15)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(8, 'Social Network class' , 'which class is Mark when he falls asleep? answers the question.it might be Computer Architecture.' ,'http://?enim=morbi&blanit=non&mi=quam&in=nec&porttitor=dui&pede=luctus&justo=rutrum&eu=&at=vel&ven', '2021-07-01', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(10, 'in the Daniel  movies	T','he most recent installments of featuring Daniel Craig have fewer gadgets but more raw action like' ,	'https://?mi=varus&in=nulla&porttitor=facilisi&pede=cras&justo=non&eu=velit&massa=nec&donec=nisi&ve', '2021-08-01', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'write instead Carpenter?',	'There is something I always found odd about the soundtrack of Johns 1982 version'	,'https://?phasellus=dui&sit=nec&amt=nisi&erat=volutpat&nulla=eleifend&tempus=donec&vivamus=ut&in=do', '2021-02-21', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'What layer Dream May Come', 'What Dreams May Come Robin Williams character Chris Nielsen travels through hell.',	'https://?dis=sed&parturient=lcus&montes=morbi&nascetur=sem&ridiculus=mauris&mus=laoreet&etiamahoncu', '2021-04-07', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(12, 'What is Harveys purpose?'	,'Apparently he has chosen Elwood, Dowd as some sort of medium to make people aware of him and contact',	'https://est=sed&donec=magna&odio=at&justo=nunc&sollicitudin=commodo&ut=placerat&suscipit=ngede&diam', '2021-03-15', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'the opening break scene', 'Mark and Erica talking about knowledge of people in China, and Marks  with getting into the Club.'	,'http://?turpiseget&donec=eros&posuere=elementum&metus=pellentesque&vitae=quisque&ipsum=porta&aliqua', '2021-06-15', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(13, 'Movie about army soldiers', 'I am trying to remember the name of a movie where there is a group of soldiers from the reserve', 'http://?eu=dolr&est=vel&congue=est&elementum=donec&in=odio&hac=justo&habitasse=sollicitudin&platea', '2021-10-11', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'Spirits of the Past ideas','Spirits of the Past Toola at the beginning receives a phonecall which she doesnt end up ',	'https://?tellus=morbinisi=non&eu=lectus&orci=aliquam&mauris=sit&lacinia=amet&sapien=diam&q', '2021-11-11', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'Ending Social Network' ,	'At the start Erica tells Mark But youre going to go through life thinking that girls dont like you', 'http://?dus=pretium&ac=quis&nibh=lectus&fusce=suspendisse&lacus=potenti&purus=in&aliquet=eleifend&a', '2021-12-18', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'character Operat Systems',	 'He then storms out and answers the professors question accurately.',	'https://?elit=integer&ac=a&nulla=nibh&sd=in&vel=quis&enim=justo&sit=maecenas&amet=rhoncus&nunc=ali', '2021-12-12', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(18, 'scene ending represent','What does this scene depict? How does it relate to the movie?',	'https://?in=dolor&faucibus=morbi&orci=vel&lucts=lectus&et=in&ultrices=quam&posuere=fringilla&cubil', '2021-12-04', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'What detail looking for', 	'I understand that Leonard Shelby has amnesia which makes him unable to keep new memories.', 'http://?mauris=sciis&lacinia=natoque&sapien=penatibus&quis=et&libero=magnis&nullam=dis&sit=par', '2021-12-01', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(11, 'Snow based off real film?' , 'The movie was set in Santas workshop, and featured Christmas hobgoblins and Little Bo Peep.', 	'https://non=felis&pretium=sed&quis=lacus&lectus=morbi&suspendisse=sem&potenti=mauris&in=laoreet&ele', '2021-04-04', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'Explanation end monolog',	'in the name of charity and good will, shepherds the weak through the valley of the darkness.',	'https://?ulrices=ipsum&erat=integer&tortor=a&sollicitudin=nibh&mi=in&sit=quis&amet=justo&lobortis=', '2021-11-12', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'Dragon Tattoo', 'What the unique point for this teaser within those three months before the trailer was released?', 	'https://?tempu=aliquam&sit=sit&amet=amet&sem=diam&fusce=in&consequat=magna&nulla=bibendum&nisl', '2021-09-01', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(11, 'Why the reflection match?','Stevens looks in the train bathroom mirror and sees Sean Fentress, a teacher', 'http://?mattis=at&egestasvulputate&metus=vitae&aenean=nisl&fermentum=aenean&donec=lectus&ut=pel', '2021-08-12', 65,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(12, 'Vincents Spikes similar?','Spike is thrown off and almost dies.What Vincent and Spike share for him to say such a statement?',	'http//?orci=volutpat&luctus=quam&et=pede&ultrices=lobortis&posuere=ligula&cubilia=sit&curae=amet&d', '2021-07-01', 65,14)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'Nightmare on Elm Street?',	'A Nightmare on Elm Street</a>? Does <em>Elm tree</em> represent something bad in the horror context?',	'htps://?amet=diam&consectetuer=neque&adipiscing=vestibulum&elit=eget&proin=vulputate&interdum=u', '2021-03-01', 624,4)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(16, 'What happened to the last','Wrath and Pride.And also is the scene in which the head of a woman (detectives wife?',	'http://?sollicitdin=in&ut=sagittis&suscipit=dui&a=vel&feugiat=nisl&et=duis&eros=ac&vestibulum=nibh&', '2021-01-01', 30,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(17, 'ages switched in the film','His casting led Spielberg to reverse the ages of the children.Is that the only reason?',	'https://?viamus=eu&vel=est&nulla=congue&eget=elementum&eros=in&elementum=hac&pellentesque=habitass', getdate(), 20,13)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'What significance does it','In the Coen brothers,movie the detective Marge Gunderson gets called by and meets an old schoolmate','https://?sed=cubiliainterdum=curae', getdate(), 1,90)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'immortality of the gods','Without placing the emphasis on mythology and on the script alone, has the power of the sea right?', 'http://?consequat=parturient&dui=montes&nec=nascetur&nisi=ridiculus&volutpat=mus&eleifend=etiam&do', getdate(), 1,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'What role does Daniels','What did LaGravenese want to portray with this bluntness towards Holly?',	'http://?nunc=sit&vestibulum=amet&ante=turpis&ipsum=elementum&primis=ligula&in=vehicula&faucibus=', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(10, 'The Envy killing','amazingly good movie, but among its weaknesses is the Envy killing.I found the justification for it', 'http://?sit=maecenas&amet=tristique&eleifend=est&pede=et&libero=tempus&quis=semper&orci=est&nullam', getdate(), 20,97)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(11, 'why is Tony Stark fooled',	'Why does he not realize as soon as he gets back that the conditions of his imprisonment','http://?vulputate=risus&nonummy=semper&maecenas=porta&tincidunt=volutpat&lacus=quam&at=pede&velit', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(5, 'digitization experienced',	'Stevens experiences the world appear to disintegrate, and digitize. While watching the movie',	'https://?eget=suspendisse&tempus=ornare&vel=consequat&pede=lectus&morbi=in&porttitor=est&lorem=', getdate(), 21,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(6, 'What 80s movie was first',	'We all know that 80s movies were famous for their montages', 'http://?enim=ut&blandit=massa&mi=quis&in=augue&porttitor=luctus&pede=tincidunt&justo=nulla&eu=molli', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(7, 'Weasley house destroyed', 	'The destruction of the house added  plot element and it was not in the book.The home was basically', 'http://?non=dui&quam=proin&nec=leo&dui=odio&luctus=porttitor&rutrum=id&nulla=conseq', getdate(), 2,94)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(8, 'feature a talking animal?',	'What the first live-action to feature talking animal, and did the film predate the first live-action',	'http://?dapibus=leo&augue=odio&vel=porttitor&accumsan=id&tellus=consequat&nisi=in&eu=consequat&orci=', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(9, 'get everyone play along?',	'Shutter Island is a really fascinating, thought,How did they manage to get everyone to play along?',	'https://?in=duis&eleifend=at&quam=velit&a=eu&odio=est&in=congue&hac=elementum&habitasse=in&platea=ha', getdate(), 200,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(10, 'Is there any real-world',	'wakes up after night of sleepwalking with numbers written onsrcI know that within the film numbers',	'http://?nunc=ut&donec=at&quis=dolor&orci=quis&eget=odio&orci=consequat&vehicula=varius&condimentum=', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(11, 'George Mcfly employ',  'here Marty goes back to 1955 and devises a plan for his father George McFly to win over Lorraine in order',	'https://?pede=neque&venenatis=duis&non=bibendum&sodales=morbi&sed=non&tincidunt=quam&eu=nec&felis=du', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(12, 'Can explain the sequence',	'Primer is one crazy movie, as far as the complicated plot goes. Has anyone figured out the sequence',	'https://?id=tempus&luctus=vivamus&nec=in&molestie=felis&sed=eu&justo=sa', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(13, 'What is a chemistry test?', 'In the context of casting for a movie, what is a chemistry test and how is it performed?', 'https://?consequat=justo&varius=in&integer=hac&ac=habitasse&leo=platea&pellentesque=dictumst&ultric', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'Why the Katayanagi Twins',	'Gideon Graves were all fleshed out rather decently by having their own epic fight scene as well as','https://?tortor=congue&quis=risus&turpis=semper&sed=porta&ante=volutpat&vivamus=quam&tortor=pede&dui', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'Does it matter the order', 'Western, so Im looking to give the genre a try.The Good,the Bad and the seems to be the most popula','https://?in=aenean&tempor=sit&turpis=amet&nec=justo&euismod=morbi&scelerisque=ut&quam=odio&turpis=c', getdate(), 2,100)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'American Psycho protsang',	'When Dexter goes to acquire his drugs for the tranquilizers he uses the name Patrick Bateman.','https://?in=imperdiet&congue=sapien&etiam=urna&justo=pretium&etiam=nisl&pretium=ut&iaculis=volutpat&', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(20, 'playing theater in Theory',	'There is a relatively brief scene in Conspiracy Theory where the main character runs into a theater.',	'https://?condimentum=cursus&neque=vestibulum&sapien=proin&placerat=eu&ante=mi&nulla=nulla&justo=ac&a', getdate(), 204,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(8, 'What going in Drive?',	'hard to grasp and that probably there is no simple answer to this question, there are different ways',	'http://?quam=tellus&turpis=nulla&adipiscing=ut&lorem=erat&vitae=id&mattis=mauris&nibh=vulputate&lig', getdate(), 210,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(9, 'Where the Wild Things', 'Are What really is the message behind the movie,Where The Wild Things Are Ive seen the movie year ago',	'https://?dictumst=morbi&aliquam=vel&augue=lectus&quam=in&sollicitudin=quam&vitae=fringilla&consect', getdate(), 29,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(7, 'opening quote from', 'movie Before starting the movie A great civilization is not conquered from without until it has destroyed', 	'https://?lorem=eros&ipsum=elementum&dolor=pellentesque&sit=quisque&amet=porta&consectetuer=volutpa', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(7, 'hrough the sea near', 'they know thats very riskyWhy do they do that?What they try to achieve in the Mediterranean Sea?',	'https://?dui=in&maecenas=consequat&tristique=ut&est=nulla&et=sed&tempus=accumsan&semper=', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(11, 'Donnie Darko set',  'the 80s Donnie Dark is timed in the 80s but the movie was released 2001. I can see no significance','https://?rhoncus=sem&aliquet=praesent&pulvinar=id&sed=massa&nisl=id&nunc=nisl&rhoncus=venenatis&dui', getdate(), 20,9)
insert into Posts(user_id, post_title, post_description, post_url, post_date, post_likes, post_disslike) values(12, 'Who Thomas Granger?','In Primer there is a secondary character named Thomas Granger that the two main characters','https://?diam=risus&erat=auctor&fermentum=sed&justo=tristique&nec=in&condimentum=tempus&neque=sit&s', getdate(), 20,1)


----------------------------


insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(2, 10, 0, getdate(), 'this is a very good day', 1,1)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(10, 10, 0, getdate(), 'I dont believe i this things', 1,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(10, 10, 1, getdate(), 'how there was good days', 1,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(11, 4, 1, getdate(), 'check it oy now', 0,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(12, 11, 1, getdate(), 'good job!! ', 0,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(12, 11, 1, getdate(), 'very good job', 0,10)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(20, 12, 0, getdate(), 'i like thos post', 0,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(13, 12, 0, getdate(), 'what if its not true', 0,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(14, 13, 0, getdate(), 'stop talking about it', 2,11)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(14, 14, 2, getdate(), 'watch the new post', 3,1)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(17, 15, 2, getdate(), 'super cool', 4,1)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(2, 16, 0, getdate(), 'I like this version', 5,2)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(3, 12, 0, getdate(), 'super cool', 6,13)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(3, 19, 2, getdate(), 'what this meaning', 1,4)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(4, 19, 2, getdate(), 'great', 17,6)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(4, 19, 3, getdate(), '', 18,7)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(5, 19, 3, getdate(), 'I dissagree with you about it', 12,2)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(6, 11, 3, getdate(), 'I dont think like you', 1,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(7, 12, 3, getdate(), 'You make it very simple', 1,10)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(7, 1, 5, getdate(), 'Good news', 10,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(6, 1, 7, getdate(), 'If it correct then its good', 12,9)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(8, 2, 8, getdate(), 'No way', 1,16)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(8, 13, 0, getdate(), 'How very good answer', 1,12)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(9, 3, 0, getdate(), 'I hope you didnt write it', 0,0)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(9, 4, 0, getdate(), 'You better think twice', 1,4)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(9, 4, 0, getdate(), 'I know im the only one', 1,7)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(2, 4, 0, getdate(), 'When you posted it?', 1,3)
insert into Comments(post_id, user_id, parent_id, comment_date, comment_content, comment_likes, comment_dislikes) values(20, 6, 0, getdate(), 'WOW!', 1,0)

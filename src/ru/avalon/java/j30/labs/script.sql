-- Создание таблиц (изменены некоторые поля, по сравнению с картинкой, для читабельности при вводе данных в таблицу):
CREATE table UserInfo 
(
id int not null -- не может быть null
       primary key -- Первичный ключ этой таблицы (он автоматически уникальный)
       generated always 
                 as identity (start with 1, increment by 1), -- Id автоматически инкрементируется при добавлении нового пользователя
name varchar(255),
surname varchar(255)
);

CREATE table Roles
(
id int not null -- не может быть null
       unique -- Ключ уникальности для id - не может повторяться
       generated always 
                 as identity (start with 1, increment by 1), -- Id автоматически инкрементируется при добавлении нового пользователя
name varchar(255) not null
                  primary key -- Первичный ключ этой таблицы (он автоматически уникальный)
);

CREATE table Users
(
id int not null
       unique, -- Ключ уникальности для id - не может повторяться
email varchar(255) not null
                   primary key, -- Первичный ключ этой таблицы
password varchar(255) not null,
info int not null
         unique, -- Ключ уникальности для info - не может повторяться
role_ varchar(255) not null, 

constraint fk_users_info foreign key (info)
                         references UserInfo(id),
constraint fk_users_roles foreign key (role_)
                          references Roles(name)
);

CREATE table Orders
(
id int not null 
       primary key -- Первичный ключ этой таблицы
       generated always 
                 as identity (start with 1, increment by 1), -- Id автоматически инкрементируется при добавлении нового пользователя
users int not null,
created timestamp not null,

constraint fk_order_users foreign key (users)
                          references Users(id)
);


CREATE table Supplier 
(
id int not null
       unique -- Ключ уникальности для id - не может повторяться
       generated always 
                 as identity (start with 1, increment by 1), -- Id автоматически инкрементируется при добавлении нового пользователя
name varchar(255) not null
                  primary key,
address varchar(255),
phone varchar(255) not null,
representative varchar(255)
);

CREATE table Product
(
id int not null
       unique -- Ключ уникальности для id - не может повторяться
       generated always 
                 as identity (start with 1, increment by 1), -- Id автоматически инкрементируется при добавлении нового пользователя
code varchar(255) not null
                  primary key,
title varchar(255) not null,
supplier varchar(255) not null,
initial_price double not null,
retail_value double not null,

constraint fk_product_supplier foreign key (supplier)
                               references Supplier(name)
);

CREATE table Order2Product
(
orders int not null,
product int not null,

constraint fk_order2product_order foreign key (orders)
                                  references Orders(id),
constraint fk_order2product_product foreign key (product)
                                    references Product(id),

-- Первичный ключ для комбинации заказа и продукта (чтобы в одном заказе нельзя было купить один и тот же товар больше 1 раза)
constraint pk_order2product_orderAndProduct primary key (orders, product)
);

-- Добавление записей в таблицы (в правильном порядке):

insert into UserInfo(name, surname)
       values ('Андрей', 'Андреевич');
insert into UserInfo(name, surname)
       values ('Игорь', 'Игоревич');
insert into UserInfo(name, surname)
       values ('Николай', 'Николаевич');

insert into ROLES("NAME")
       values ('customer');
insert into ROLES("NAME")
       values ('customer wholesale');
insert into ROLES("NAME")
       values ('seller');

insert into Users(ID, INFO, ROLE_, EMAIL, PASSWORD)
       values (1, 1, 'customer', 'avalon@yandex.ru', 'qwerty');
insert into Users(ID, INFO, ROLE_, EMAIL, PASSWORD)
       values (2, 2, 'customer', 'qwerty@gmail.com', '1234');
insert into Users(ID, INFO, ROLE_, EMAIL, PASSWORD)
       values (3, 3, 'customer', '1234@mail.ru', 'avalon');

insert into Supplier("NAME", PHONE)
       values ('Газпром', '+7(921)999-00-01');
insert into Supplier("NAME", PHONE)
       values ('Ozon', '+7(921)999-00-02');
insert into Supplier("NAME", PHONE)
       values ('Пятерочка', '+7(921)999-00-03');

insert into Product(CODE, TITLE, SUPPLIER, INITIAL_PRICE, RETAIL_VALUE)
       values ('GAZ_RUS', 'Газ', 'Газпром', 300, 500);
insert into Product(CODE, TITLE, SUPPLIER, INITIAL_PRICE, RETAIL_VALUE)
       values ('Oil_RUS', 'Нефть', 'Газпром', 999, 1000);
insert into Product(CODE, TITLE, SUPPLIER, INITIAL_PRICE, RETAIL_VALUE)
       values ('Book_JAVA', 'КнигаJava', 'Ozon', 499, 600);
insert into Product(CODE, TITLE, SUPPLIER, INITIAL_PRICE, RETAIL_VALUE)
       values ('Bread', 'Хлеб', 'Пятерочка', 30, 50);

insert into Orders(USERS, CREATED)
       values (1, '2019-05-31-15.14.00');
insert into Orders(USERS, CREATED)
       values (1, '2019-05-31-15.14.01');
insert into Orders(USERS, CREATED)
       values (2, '2019-05-31-15.16.00');
insert into Orders(USERS, CREATED)
       values (2, '2019-05-31-15.18.00');
insert into Orders(USERS, CREATED)
       values (3, '2019-05-31-23.59.59');

insert into ORDER2PRODUCT(ORDERS, PRODUCT)
       values (1, 1);
insert into ORDER2PRODUCT(ORDERS, PRODUCT)
       values (1, 2);
insert into ORDER2PRODUCT(ORDERS, PRODUCT)
       values (1, 3);
insert into ORDER2PRODUCT(ORDERS, PRODUCT)
       values (3, 2);
insert into ORDER2PRODUCT(ORDERS, PRODUCT)
       values (2, 3);
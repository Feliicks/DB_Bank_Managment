DROP DATABASE IF EXISTS  proyecto_bank;
CREATE DATABASE proyecto_bank;
USE proyecto_bank;
CREATE TABLE bank (
  id_bank int(10) PRIMARY KEY AUTO_INCREMENT,
  bank_name varchar(50) NOT NULL
);

CREATE TABLE atms (
  id_atm int(10) PRIMARY KEY AUTO_INCREMENT,
  atm_address varchar(50) NOT NULL,
  cash_limit int NOT NULL DEFAULT 500,
  id_bank int,
  FOREIGN KEY (id_bank) REFERENCES bank(id_bank)
);

CREATE TABLE users (
  id_user int  PRIMARY KEY AUTO_INCREMENT,
  first_name varchar (20) NOT NULL,
  last_name varchar(20) NOT NULL,
  address varchar(50) NOT NULL,
  phone varchar(15) NOT NULL
);

CREATE TABLE cards (
  id_card int(10) PRIMARY KEY AUTO_INCREMENT,
  card_num char(16) NOT NULL,
  pin char(4) NOT NULL,
  id_user int,
  id_bank int,
  UNIQUE KEY (card_num),
  FOREIGN KEY (id_user) REFERENCES users(id_user) ,
  FOREIGN KEY (id_bank) REFERENCES bank(id_bank)
);

CREATE TABLE accounts (
  id_account int PRIMARY KEY AUTO_INCREMENT,
  balance decimal NOT NULL,
  id_bank int,
  id_user int,
  id_card int,
  FOREIGN KEY (id_user) REFERENCES users(id_user),
  FOREIGN KEY (id_bank) REFERENCES bank(id_bank),
  FOREIGN KEY (id_card) REFERENCES cards(id_card)
);
CREATE TABLE deposit (
  id_dep int PRIMARY KEY AUTO_INCREMENT,
  trans_amount decimal(10, 2) NOT NULL,
  id_account int,
  trans_date DATE DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (id_account) REFERENCES accounts (id_account)
);
CREATE TABLE retiros (
  id_trans int(10) PRIMARY KEY AUTO_INCREMENT,
  trans_amount decimal NOT NULL,
  id_account int,
  trans_date DATE DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (id_account) REFERENCES accounts (id_account)
);

CREATE TRIGGER trig_balance_dep
AFTER INSERT ON deposit FOR EACH ROW
UPDATE accounts
SET balance = balance + NEW.trans_amount
WHERE NEW.id_account = accounts.id_account;

CREATE TRIGGER trig_balance_ret
AFTER INSERT ON retiros FOR EACH ROW
UPDATE accounts
SET balance = balance - NEW.trans_amount
WHERE NEW.id_account = accounts.id_account;


DROP PROCEDURE  IF EXISTS ras_num_card;
CREATE PROCEDURE ras_num_card (num_card INT)
BEGIN

    SELECT b.bank_name,usu.id_user, CONCAT(usu.first_name,' ',usu.last_name) AS Usuario ,acc.id_account, acc.id_card, trans_date, dep.trans_amount, 'DEPOSITO' as TRANSACCION
    FROM accounts AS acc
JOIN proyecto_bank.deposit dep on acc.id_account = dep.id_account
    JOIN users AS usu on acc.id_user = usu.id_user
    join proyecto_bank.bank b on acc.id_bank = b.id_bank
where acc.id_account= num_card
    UNION
SELECT b.bank_name, usu.id_user, CONCAT(usu.first_name,' ',usu.last_name),acc.id_account, acc.id_card, trans_date, ret.trans_amount AS Monto, 'RETIRO' AS TRANSACCION
    FROM accounts AS acc
JOIN proyecto_bank.retiros ret on acc.id_account = ret.id_account
join proyecto_bank.bank b on acc.id_bank = b.id_bank
    JOIN users AS usu on acc.id_user = usu.id_user
where acc.id_account= num_card;
end;
#CALL ras_num_card(1);

##RETIROS EN EL 2022

DROP PROCEDURE  IF EXISTS ras_year_ret;
CREATE PROCEDURE ras_year_ret (num_card INT, yearr char(4))
BEGIN
SELECT b.bank_name,usu.id_user, CONCAT(usu.first_name,' ',usu.last_name)AS Usuario ,acc.id_account, acc.id_card, trans_date, r.trans_amount
    FROM accounts AS acc
        JOIN retiros r on acc.id_account = r.id_account
    JOIN users AS usu on acc.id_user = usu.id_user
    join proyecto_bank.bank b on acc.id_bank = b.id_bank
    where SUBSTR(r.trans_date,1,4)=yearr AND acc.id_account=num_card;
end;
##CALL ras_year_ret(1,'2022');


##DEPOSITSO EN 2022

DROP PROCEDURE  IF EXISTS ras_year_dep;
CREATE PROCEDURE ras_year_dep (num_card INT, yearr char(4))
BEGIN
SELECT b.bank_name,usu.id_user, CONCAT(usu.first_name,' ',usu.last_name),acc.id_account, acc.balance, acc.id_card, trans_date, dep.trans_amount
    FROM accounts AS acc
     JOIN proyecto_bank.deposit dep on acc.id_account = dep.id_account
    JOIN users AS usu on acc.id_user = usu.id_user
    join proyecto_bank.bank b on acc.id_bank = b.id_bank
    where SUBSTR(dep.trans_date,1,4)=yearr AND acc.id_account=num_card;
end;
##CALL ras_year_dep(1,'2022');






## VISTA PARA VER LOS ULTIMOS MOVIMIENTOS



CREATE OR REPLACE VIEW last_movements AS
SELECT *
FROM
     (
     SELECT usu.id_user, CONCAT(usu.first_name,' ',usu.last_name) as USUARIO, acc.id_account AS num_de_cuenta,acc.id_card , trans_date, dep.trans_amount AS Monto ,'DEPOSITO' as TRANSACCION
FROM accounts AS acc
JOIN proyecto_bank.deposit dep on acc.id_account = dep.id_account
JOIN users AS usu on acc.id_user = usu.id_user
    UNION
SELECT usu.id_user, CONCAT(usu.first_name,' ',usu.last_name) as usuario,acc.id_account AS num_de_cuenta,  acc.id_card , trans_date, ret.trans_amount AS Monto, 'RETIRO' AS TRANSACCION
FROM accounts AS acc
JOIN proyecto_bank.retiros ret on acc.id_account = ret.id_account
JOIN users AS usu on acc.id_user = usu.id_user
) as A
order by trans_date desc ;



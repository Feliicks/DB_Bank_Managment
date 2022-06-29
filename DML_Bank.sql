
INSERT INTO proyecto_bank.bank (id_bank, bank_name) VALUES (1, 'Banco Nacional de Bolivia');
INSERT INTO proyecto_bank.bank (id_bank, bank_name) VALUES (2, 'Banco Union');
INSERT INTO proyecto_bank.bank (id_bank, bank_name) VALUES (3, 'Banco Central De Bolivia');

INSERT INTO proyecto_bank.atms (id_atm, atm_address, cash_limit, id_bank) VALUES (1, 'Av. Carretera', 500, 1);
INSERT INTO proyecto_bank.atms (id_atm, atm_address, cash_limit, id_bank) VALUES (2, 'Av. Brasil', 660, 2);
INSERT INTO proyecto_bank.atms (id_atm, atm_address, cash_limit, id_bank) VALUES (3, 'Av. Mariscal Santa Cruz', 800, 3);

INSERT INTO proyecto_bank.users (id_user, first_name, last_name, address, phone) VALUES (1, 'Alberto', 'Cruz', 'zona aeropuerto 4892', '59148642395');
INSERT INTO proyecto_bank.users (id_user, first_name, last_name, address, phone) VALUES (2, 'Jaime', 'Loredo', 'plaza uyuni 5495', '59145629765');
INSERT INTO proyecto_bank.users (id_user, first_name, last_name, address, phone) VALUES (3, 'Abigail', 'Llanos', 'plaza murrillo', '5684459877');
INSERT INTO proyecto_bank.users (id_user, first_name, last_name, address, phone) VALUES (4, 'Arleth', 'Morales', 'Chasquipampa', '59148953489');

INSERT INTO proyecto_bank.cards (id_card, card_num, pin, id_user, id_bank) VALUES (1, '4775635569056854', '8945', 1, 2);
INSERT INTO proyecto_bank.cards (id_card, card_num, pin, id_user, id_bank) VALUES (2, '4474003592573714', '4589', 2, 2);
INSERT INTO proyecto_bank.cards (id_card, card_num, pin, id_user, id_bank) VALUES (3, '4102591369018749', '1596', 3, 3);
INSERT INTO proyecto_bank.cards (id_card, card_num, pin, id_user, id_bank) VALUES (4, '4503926436731087', '8794', 4, 1);
INSERT INTO proyecto_bank.cards (id_card, card_num, pin, id_user, id_bank) VALUES (5, '4588600203275762', '7749', 4, 1);

INSERT INTO proyecto_bank.accounts (id_account, balance, id_bank, id_user, id_card) VALUES (1, 661, 3, 4, 4);
INSERT INTO proyecto_bank.accounts (id_account, balance, id_bank, id_user, id_card) VALUES (2, 200, 3, 4, 5);
INSERT INTO proyecto_bank.accounts (id_account, balance, id_bank, id_user, id_card) VALUES (3, 901, 3, 3, 3);
INSERT INTO proyecto_bank.accounts (id_account, balance, id_bank, id_user, id_card) VALUES (4, 1251, 2, 2, 2);
INSERT INTO proyecto_bank.accounts (id_account, balance, id_bank, id_user, id_card) VALUES (5, 1501, 2, 1, 1);

INSERT INTO proyecto_bank.deposit (id_dep, trans_amount, id_account, trans_date) VALUES (1, 150, 1, '2022-06-25 00:00:00');
INSERT INTO proyecto_bank.deposit (id_dep, trans_amount, id_account, trans_date) VALUES (2, 350, 2, '2022-06-25 00:00:00');


INSERT INTO proyecto_bank.retiros (id_trans, trans_amount, id_account, trans_date) VALUES (1, 250.00, 4, '2022-06-25 00:00:00');
INSERT INTO proyecto_bank.retiros (id_trans, trans_amount, id_account, trans_date) VALUES (2, 200.00, 5, '2022-06-25 00:00:00');


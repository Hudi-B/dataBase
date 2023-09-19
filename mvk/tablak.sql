CREATE TABLE viszonylatok(
viszonylatjelzes varchar(4) NOT NULL,
irveg varchar(200) NOT NULL,
kulsoveg varchar(200) NOT NULL,
fordtav real NOT NULL,
CONSTRAINT pk_viszonylatok PRIMARY KEY (viszonylatjelzes)
);

CREATE TABLE viszonylatadatok(
viszonylatazon varchar(4) NOT NULL,
elsojarat time NOT NULL,
utolsojarat time NOT NULL,
jszamtel int(3) NOT NULL,
jszamnyar int(3) NOT NULL,
CONSTRAINT pk_viszonylatadatok PRIMARY KEY (viszonylatazon),
CONSTRAINT fk_viszonylatadatok FOREIGN KEY (viszonylatazon) REFERENCES viszonylatok(viszonylatjelzes)
);

CREATE TABLE utasszamok(
viszonylatazon varchar(4) NOT NULL,
utasszam int (6),
CONSTRAINT pk_utasszamok PRIMARY KEY (viszonylatazon),
CONSTRAINT fk_utasszamok FOREIGN KEY (viszonylatazon) REFERENCES viszonylatok(viszonylatjelzes)
);
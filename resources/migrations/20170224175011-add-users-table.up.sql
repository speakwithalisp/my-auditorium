CREATE TABLE seats(
        id int PRIMARY KEY AUTO_INCREMENT,
        seat_name VARCHAR(4) NOT NULL
        );
--;;
INSERT INTO seats (seat_name) VALUES
('A1'),('A2'),('A3'),('A4'),('A5'),('A6'),('A7'),('A8'),('A9'),('A10'),('A11'),('A12'),('A13'),('A14'),('A15'),('A16'),('A17'),('A18'),('A19'),('A20'),('A21'),('A22'),('A23'),('A24'),('A25'),('A26'),('A27'),('A28'),('A29'),('A30'),('A31'),('A32'),('A33'),('A34'),('A35'),('A36'),('A37'),('A38'),('A39'),('A40'),('A41'),('A42'),('A43'),('A44'),('A45'),('A46'),('A47'),('A48'),('A49'),('A50'),('A51'),('A52'),('A53'),('A54'),('A55'),('A56'),('A57'),('A58'),('A59'),('A60'),('A61'),('A62'),('A63'),('A64'),('A65'),('A66'),('A67'),('A68'),('A69'),('A70'),('A71'),('A72'),('A73'),('A74'),('A75'),('A76'),('A77'),('A78'),('A79'),('A80'),('A81'),('A82'),('A83'),('A84'),('A85'),('A86'),('A87'),('A88'),('A89'),('A90'),('A91'),('A92'),('A93'),('A94'),('A95'),('A96'),('A97'),('A98'),('A99'),('A100'),('A101'),('A102'),('A103'),('A104'),('A105'),('A106'),('A107'),('A108'),('A109'),('A110'),('A111'),('A112'),('A113'),('A114'),('A115'),('A116'),('A117'),('A118'),('A119'),('A120'),('A121'),('A122'),('A123'),('A124'),('A125'),('A126'),('A127'),('A128'),('A129'),('A130'),('A131'),('A132'),('A133'),('A134'),('A135'),('A136'),('A137'),('A138'),('A139'),('A140'),('A141'),('A142'),('A143'),('A144'),('A145'),('A146'),('A147'),('A148'),('A149'),('A150'),('A151'),('A152'),('A153'),('A154'),('A155'),('A156'),('A157'),('A158'),('A159'),('A160'),('A161'),('A162'),('A163'),('A164'),('A165'),('A166'),('A167'),('A168'),('A169'),('A170'),('A171'),('A172'),('A173'),('A174'),('A175'),('A176'),('A177'),('A178'),('A179'),('A180'),('A181'),('A182'),('A183'),('A184'),('A185'),('A186'),('A187'),('A188'),('A189'),('A190'),('A191'),('A192'),('A193'),('A194'),('A195'),('A196'),('A197'),('A198'),('A199'),('A200'),('A201'),('A202'),('A203'),('A204'),('A205'),('A206'),('A207'),('A208'),('A209'),('A210'),('A211'),('A212'),('A213'),('A214'),('A215'),('A216'),('A217'),('A218'),('A219'),('A220'),('A221'),('A222'),('A223'),('A224'),('A225'),('A226'),('A227'),('A228'),('A229'),('A230'),('A231'),('A232'),('A233'),('A234'),('A235'),('A236'),('A237'),('A238'),('A239'),('A240'),('A241'),('A242'),('A243'),('A244'),('A245'),('A246'),('A247'),('A248'),('A249'),('A250'),('A251'),('A252'),('A253'),('A254'),('A255'),('A256'),('A257'),('A258'),('A259'),('A260'),('A261'),('A262'),('A263'),('A264'),('A265'),('A266'),('A267'),('A268'),('A269'),('A270'),('A271'),('A272'),('A273'),('A274'),('A275'),('A276'),('A277'),('A278'),('A279'),('A280'),('A281'),('A282'),('A283'),('A284'),('A285'),('A286'),('A287'),('A288'),('A289'),('A290'),('A291'),('A292'),('A293'),('A294'),('A295'),('A296'),('A297'),('A298'),('A299'),('A300');
--;;
CREATE TABLE shows
    (id int PRIMARY KEY AUTO_INCREMENT,
        slot int NOT NULL UNIQUE,
        show_name VARCHAR(200) NOT NULL,
        created_on TIMESTAMP
        );
--;;
CREATE TABLE show_seats
    (
        show_id int,
        seat_id int,
        PRIMARY KEY (show_id, seat_id),
FOREIGN KEY (show_id) REFERENCES shows (id),
FOREIGN KEY (seat_id) REFERENCES seats (id)
        );
--;;
CREATE TABLE bookings
    (
        id int PRIMARY KEY AUTO_INCREMENT,
        show_id int,
        seat_id int,
        created_on TIMESTAMP,
        FOREIGN KEY (seat_id) REFERENCES seats(id),
        FOREIGN KEY (show_id) REFERENCES shows(id)
        );

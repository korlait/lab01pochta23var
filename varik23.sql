-- Лабораторная работа №1. Вариант 23
-- PostgreSQL. База данных: выполните этот скрипт в Query Tool
-- текущей базы данных. Данные учебные.

CREATE TABLE IF NOT EXISTS pochta_otdeleniya (
    code_poch_otd INTEGER PRIMARY KEY,
    address VARCHAR(150) NOT NULL,
    city VARCHAR(60) NOT NULL,
    district VARCHAR(60) NOT NULL,
    postal_index VARCHAR(6) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS priem_korrespondencii (
    track_number VARCHAR(20) NOT NULL,
    code_poch_otd INTEGER NOT NULL,
    received_at TIMESTAMP NOT NULL,
    declared_value NUMERIC(10, 2) NOT NULL DEFAULT 0
        CHECK (declared_value >= 0),
    shipping_cost NUMERIC(10, 2) NOT NULL
        CHECK (shipping_cost >= 0),
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    sent_at TIMESTAMP,
	PRIMARY KEY (track_number, received_at),
    CONSTRAINT fk_priem_pochta
        FOREIGN KEY (code_poch_otd)
        REFERENCES pochta_otdeleniya(code_poch_otd)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO pochta_otdeleniya
(code_poch_otd, address, city, district, postal_index, phone)
VALUES
(1, 'ул. Тверская, д. 8', 'Москва', 'Тверской', '125009', '+7-495-100-00-01'),
(2, 'ул. Арбат, д. 15', 'Москва', 'Арбат', '119002', '+7-495-100-00-02'),
(3, 'пр-т Мира, д. 45', 'Москва', 'Мещанский', '129110', '+7-495-100-00-03'),
(4, 'ул. Профсоюзная, д. 20', 'Москва', 'Черёмушки', '117418', '+7-495-100-00-04'),
(5, 'Ленинградский пр-т, д. 30', 'Москва', 'Аэропорт', '125040', '+7-495-100-00-05'),
(6, 'ул. Бауманская, д. 10', 'Москва', 'Басманный', '105005', '+7-495-100-00-06'),
(7, 'Варшавское шоссе, д. 26', 'Москва', 'Нагорный', '117556', '+7-495-100-00-07'),
(8, 'ул. Люблинская, д. 5', 'Москва', 'Люблино', '109387', '+7-495-100-00-08'),
(9, 'ул. Садовая-Каретная, д. 12', 'Москва', 'Тверской', '127030', '+7-495-100-00-09'),
(10, 'ул. Ярославская, д. 7', 'Москва', 'Алексеевский', '129164', '+7-495-100-00-10')
ON CONFLICT (code_poch_otd) DO NOTHING;

INSERT INTO priem_korrespondencii
(track_number, code_poch_otd, received_at, declared_value, shipping_cost, paid, sent_at)
VALUES
('RU2300000001', 1, '2026-11-01 09:15:00', 1500.00, 420.00, TRUE, '2026-11-01 14:30:00'),
('RU2300000002', 2, '2026-11-02 10:20:00', 0.00, 310.00, TRUE, '2026-11-02 16:10:00'),
('RU2300000003', 3, '2026-11-03 11:05:00', 5000.00, 680.00, TRUE, '2026-11-04 09:00:00'),
('RU2300000004', 4, '2026-11-04 12:40:00', 250.00, 290.00, FALSE, NULL),
('RU2300000005', 5, '2026-11-05 08:55:00', 10000.00, 950.00, TRUE, '2026-11-05 18:20:00'),
('RU2300000006', 6, '2026-11-06 13:10:00', 0.00, 350.00, TRUE, '2026-11-07 10:15:00'),
('RU2300000007', 7, '2026-11-07 14:25:00', 3000.00, 540.00, FALSE, NULL),
('RU2300000008', 8, '2026-11-08 09:35:00', 750.00, 390.00, TRUE, '2026-11-08 17:45:00'),
('RU2300000009', 9, '2026-11-09 15:00:00', 2000.00, 470.00, TRUE, '2026-11-10 08:30:00'),
('RU2300000010', 10, '2026-11-10 16:15:00', 0.00, 280.00, TRUE, '2026-11-11 11:00:00')
ON CONFLICT (track_number) DO NOTHING;

-- Проверка: должны вернуться 10 строк из каждой таблицы
SELECT * FROM pochta_otdeleniya ORDER BY code_poch_otd;
SELECT * FROM priem_korrespondencii ORDER BY track_number;

-- Проверка связи между таблицами
SELECT p.track_number, o.city, o.district, p.received_at,
       p.declared_value, p.shipping_cost, p.paid, p.sent_at
FROM priem_korrespondencii AS p
JOIN pochta_otdeleniya AS o
  ON p.code_poch_otd = o.code_poch_otd
ORDER BY p.track_number;

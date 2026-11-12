--
-- PostgreSQL database dump
--

\restrict YyOarXz7uQYojouA9lZoxbtQikeOwlrpcmrAsDz0R2CxmUpafnpEItdeH9QA9Mn

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-12 14:00:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 25188)
-- Name: pochta_otdeleniya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pochta_otdeleniya (
    code_poch_otd integer NOT NULL,
    address character varying(150) NOT NULL,
    city character varying(60) NOT NULL,
    district character varying(60) NOT NULL,
    postal_index character varying(6) NOT NULL,
    phone character varying(20) NOT NULL
);


ALTER TABLE public.pochta_otdeleniya OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25199)
-- Name: priem_korrespondencii; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.priem_korrespondencii (
    track_number character varying(20) NOT NULL,
    code_poch_otd integer NOT NULL,
    received_at timestamp without time zone NOT NULL,
    declared_value numeric(10,2) DEFAULT 0 NOT NULL,
    shipping_cost numeric(10,2) NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    sent_at timestamp without time zone,
    CONSTRAINT priem_korrespondencii_declared_value_check CHECK ((declared_value >= (0)::numeric)),
    CONSTRAINT priem_korrespondencii_shipping_cost_check CHECK ((shipping_cost >= (0)::numeric))
);


ALTER TABLE public.priem_korrespondencii OWNER TO postgres;

--
-- TOC entry 4914 (class 0 OID 25188)
-- Dependencies: 219
-- Data for Name: pochta_otdeleniya; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pochta_otdeleniya (code_poch_otd, address, city, district, postal_index, phone) FROM stdin;
1	ул. Тверская, д. 8	Москва	Тверской	125009	+7-495-100-00-01
2	ул. Арбат, д. 15	Москва	Арбат	119002	+7-495-100-00-02
3	пр-т Мира, д. 45	Москва	Мещанский	129110	+7-495-100-00-03
4	ул. Профсоюзная, д. 20	Москва	Черёмушки	117418	+7-495-100-00-04
5	Ленинградский пр-т, д. 30	Москва	Аэропорт	125040	+7-495-100-00-05
6	ул. Бауманская, д. 10	Москва	Басманный	105005	+7-495-100-00-06
7	Варшавское шоссе, д. 26	Москва	Нагорный	117556	+7-495-100-00-07
8	ул. Люблинская, д. 5	Москва	Люблино	109387	+7-495-100-00-08
9	ул. Садовая-Каретная, д. 12	Москва	Тверской	127030	+7-495-100-00-09
10	ул. Ярославская, д. 7	Москва	Алексеевский	129164	+7-495-100-00-10
\.


--
-- TOC entry 4915 (class 0 OID 25199)
-- Dependencies: 220
-- Data for Name: priem_korrespondencii; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priem_korrespondencii (track_number, code_poch_otd, received_at, declared_value, shipping_cost, paid, sent_at) FROM stdin;
RU2300000001	1	2026-11-01 09:15:00	1500.00	420.00	t	2026-11-01 14:30:00
RU2300000002	2	2026-11-02 10:20:00	0.00	310.00	t	2026-11-02 16:10:00
RU2300000003	3	2026-11-03 11:05:00	5000.00	680.00	t	2026-11-04 09:00:00
RU2300000004	4	2026-11-04 12:40:00	250.00	290.00	f	\N
RU2300000005	5	2026-11-05 08:55:00	10000.00	950.00	t	2026-11-05 18:20:00
RU2300000006	6	2026-11-06 13:10:00	0.00	350.00	t	2026-11-07 10:15:00
RU2300000007	7	2026-11-07 14:25:00	3000.00	540.00	f	\N
RU2300000008	8	2026-11-08 09:35:00	750.00	390.00	t	2026-11-08 17:45:00
RU2300000009	9	2026-11-09 15:00:00	2000.00	470.00	t	2026-11-10 08:30:00
RU2300000010	10	2026-11-10 16:15:00	0.00	280.00	t	2026-11-11 11:00:00
\.


--
-- TOC entry 4763 (class 2606 OID 25198)
-- Name: pochta_otdeleniya pochta_otdeleniya_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pochta_otdeleniya
    ADD CONSTRAINT pochta_otdeleniya_pkey PRIMARY KEY (code_poch_otd);


--
-- TOC entry 4765 (class 2606 OID 25213)
-- Name: priem_korrespondencii priem_korrespondencii_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priem_korrespondencii
    ADD CONSTRAINT priem_korrespondencii_pkey PRIMARY KEY (track_number);


--
-- TOC entry 4766 (class 2606 OID 25214)
-- Name: priem_korrespondencii fk_priem_pochta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priem_korrespondencii
    ADD CONSTRAINT fk_priem_pochta FOREIGN KEY (code_poch_otd) REFERENCES public.pochta_otdeleniya(code_poch_otd) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-11-12 14:00:32

--
-- PostgreSQL database dump complete
--

\unrestrict YyOarXz7uQYojouA9lZoxbtQikeOwlrpcmrAsDz0R2CxmUpafnpEItdeH9QA9Mn


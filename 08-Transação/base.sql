--Base para testar Transações. 


-- PostgreSQL database dump
--

\restrict MkavkkqJPF1Vy0EQgDfJUbAMmm7dwlam5wORf24TBspiGlMUDdvq3zux1s1bDBx

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nome character varying(255) NOT NULL,
    fone character(20) NOT NULL,
    email character varying(255) NOT NULL,
    data_nasc date NOT NULL,
    cpf character(14) NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- Name: item_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda (
    id_venda integer NOT NULL,
    id_produto integer NOT NULL,
    qtde integer NOT NULL,
    preco numeric(7,2) NOT NULL
);


ALTER TABLE public.item_venda OWNER TO postgres;

--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id_produto integer NOT NULL,
    descricao character varying(255) NOT NULL,
    qtde_min integer NOT NULL,
    qtde_max integer NOT NULL,
    qtde integer NOT NULL,
    preco numeric(7,2) NOT NULL,
    desconto numeric(7,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: produto_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_id_produto_seq OWNER TO postgres;

--
-- Name: produto_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_id_produto_seq OWNED BY public.produto.id_produto;


--
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    id_venda integer NOT NULL,
    id_vendedor integer NOT NULL,
    id_cliente integer NOT NULL,
    data_venda timestamp without time zone DEFAULT now() NOT NULL,
    total numeric(7,2) DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- Name: venda_id_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_id_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_id_venda_seq OWNER TO postgres;

--
-- Name: venda_id_venda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_id_venda_seq OWNED BY public.venda.id_venda;


--
-- Name: vendedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedor (
    id_vendedor integer NOT NULL,
    nome character varying(255) NOT NULL,
    fone character(20) NOT NULL,
    email character varying(255) NOT NULL,
    data_nasc date NOT NULL,
    salario numeric(7,2) NOT NULL,
    comissao numeric(7,2) NOT NULL
);


ALTER TABLE public.vendedor OWNER TO postgres;

--
-- Name: vendedor_id_vendedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendedor_id_vendedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendedor_id_vendedor_seq OWNER TO postgres;

--
-- Name: vendedor_id_vendedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendedor_id_vendedor_seq OWNED BY public.vendedor.id_vendedor;


--
-- Name: vw_ivenda; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_ivenda AS
 SELECT id_venda,
    id_produto,
    qtde,
    preco,
    ((qtde)::numeric * preco) AS subtotal
   FROM public.item_venda;


ALTER VIEW public.vw_ivenda OWNER TO postgres;

--
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- Name: produto id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id_produto SET DEFAULT nextval('public.produto_id_produto_seq'::regclass);


--
-- Name: venda id_venda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda ALTER COLUMN id_venda SET DEFAULT nextval('public.venda_id_venda_seq'::regclass);


--
-- Name: vendedor id_vendedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor ALTER COLUMN id_vendedor SET DEFAULT nextval('public.vendedor_id_vendedor_seq'::regclass);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id_cliente, nome, fone, email, data_nasc, cpf) FROM stdin;
1	Ana Clara Lima	11985641234         	ana.clara@email.com	1990-05-14	123.456.789-00
2	Bruno Henrique Costa	21975439876         	bruno.hcosta@email.com	1985-03-22	321.654.987-11
3	Carla Beatriz Rocha	31988776655         	carla.rocha@email.com	1992-08-10	456.789.123-22
4	Diego Farias Almeida	41999887766         	diego.almeida@email.com	1988-11-30	789.123.456-33
5	Eduarda Silva Nunes	51997775544         	eduarda.nunes@email.com	1995-02-19	147.258.369-44
6	Felipe Tavares Pinto	61996664433         	felipe.pinto@email.com	1991-07-25	258.369.147-55
7	Gabriela Moura Soares	71995553322         	gabriela.soares@email.com	1993-10-12	963.852.741-66
8	Heitor Carvalho Reis	81994442211         	heitor.reis@email.com	1989-09-09	741.852.963-77
9	Isabela Mendes Cruz	11993331122         	isabela.cruz@email.com	1996-12-03	852.963.741-88
10	João Pedro Martins	21992220011         	joao.martins@email.com	1987-01-18	369.147.258-99
11	Karen Oliveira Dias	31991118877         	karen.dias@email.com	1994-06-28	951.753.852-10
12	Lucas Viana Ramos	41990007766         	lucas.ramos@email.com	1990-04-11	357.159.753-21
13	Mariana Lopes Ferreira	51989996655         	mariana.ferreira@email.com	1992-03-30	159.753.357-32
14	Nathan Ribeiro Silva	61988885544         	nathan.ribeiro@email.com	1997-08-15	753.159.951-43
15	Olívia Teixeira Rocha	71987774433         	olivia.rocha@email.com	1991-09-07	951.357.159-54
16	Pedro Henrique Lima	81986663322         	pedro.henrique@email.com	1986-05-20	159.951.357-65
17	Queila Santos Barreto	11985552211         	queila.barreto@email.com	1993-10-01	357.951.159-76
18	Rafael Almeida Luz	21984441100         	rafael.luz@email.com	1984-07-16	951.159.357-87
19	Sabrina Castro Leal	31983330099         	sabrina.leal@email.com	1995-11-29	753.357.951-98
20	Tiago Nunes Barros	41982229988         	tiago.barros@email.com	1988-02-08	357.753.159-09
\.


--
-- Data for Name: item_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_venda (id_venda, id_produto, qtde, preco) FROM stdin;
2	1	3	4050.00
5	6	3	1189.66
5	5	5	1986.71
5	10	1	3390.82
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id_produto, descricao, qtde_min, qtde_max, qtde, preco, desconto) FROM stdin;
9	Logitech H390	6	38	12	1587.94	224.79
11	Asus VivoBook	8	45	38	1281.14	61.92
12	Epson EcoTank L3150	8	50	21	3576.45	541.27
13	LG 24MK430	6	35	33	4810.27	193.80
14	HP DeskJet 2774	6	27	24	1598.17	134.79
15	Redragon Apex GW900	8	44	26	1946.21	34.63
16	Dell WM126	9	40	33	3270.71	629.64
17	Brother HL-1212W	10	47	45	3361.75	209.01
18	Razer DeathAdder	5	49	23	3790.16	45.92
19	Acer Aspire 5	9	38	22	3009.48	370.91
20	HyperX Cloud Stinger	10	20	18	2439.45	351.08
21	WD Elements 2TB	6	50	16	4647.28	670.89
22	Redragon Lamia	7	33	26	4634.42	133.50
23	Razer Kiyo	7	23	23	3996.46	371.89
24	Microsoft Basic	8	47	22	1714.45	155.94
25	Dell SE2419HR	5	42	23	2707.59	41.34
26	TS Shara UPS	5	24	16	2954.30	182.43
27	HP K1500	6	33	33	3502.62	648.92
28	HP HD 4310	9	40	9	2539.69	494.08
29	Samsung T350	6	23	19	2674.34	449.76
30	Canon Pixma G3110	9	28	24	3559.22	329.62
31	Logitech M170	5	35	9	3513.22	506.20
32	Logitech K120	9	48	45	4056.19	350.86
33	Razer Kraken	10	24	18	1777.42	340.91
34	Razer Kraken	9	30	25	1693.88	93.72
35	HP DeskJet 2774	8	50	39	1634.83	145.72
36	HP HD 4310	7	37	17	143.07	13.09
37	SanDisk Ultra 3D 500GB	9	21	10	1644.48	152.79
38	Dell SE2419HR	8	38	38	3337.56	32.08
39	HP Pavilion x360	10	49	13	2952.59	401.81
40	Logitech C920	5	30	12	1508.61	117.70
41	Clamper Energia	6	38	31	2424.49	169.85
42	SMS Atrium	8	28	11	2973.08	72.66
43	Samsung T5 500GB	9	35	29	4027.35	558.60
44	HP X1000	8	33	16	4705.91	407.31
45	Samsung Xpress M2020W	5	39	23	4900.83	976.80
46	SanDisk Ultra 3D 500GB	10	21	14	3499.48	609.38
47	LG 24MK430	6	42	31	1926.43	103.79
48	Microsoft LifeCam	10	42	25	3925.03	494.69
49	Brother HL-1212W	5	24	18	795.69	126.25
50	Logitech K120	9	21	19	70.12	8.61
51	Crucial MX500	7	46	30	1763.90	57.56
52	TS Shara UPS	6	46	24	4090.16	524.39
53	ADATA HD710	5	30	25	2110.46	417.54
54	AOC 24B1XHS	9	40	21	3482.99	354.67
55	Razer DeathAdder	10	29	23	4032.50	659.25
56	Logitech K120	8	34	25	2478.22	136.49
57	Dell SE2419HR	6	38	22	3828.44	462.97
58	HP K1500	9	31	18	2303.44	325.40
59	Microsoft LifeCam	7	23	12	2450.50	387.99
60	Asus VivoBook	8	35	30	2694.67	299.79
61	Samsung T5 500GB	10	50	20	4880.91	165.91
62	LG 24MK430	7	35	35	2134.06	15.30
63	Dell SE2419HR	8	29	20	2289.97	218.63
64	Corsair K55	8	42	14	3680.02	587.50
65	APC Back-UPS	8	41	11	4241.01	476.40
66	Intelbras XNB 600	6	38	22	4935.83	872.40
67	Crucial MX500	10	49	27	844.86	40.19
68	Canon Pixma G3110	6	32	19	1735.39	135.06
69	Crucial MX500	7	34	27	582.04	74.30
70	Lenovo Ideapad 3	7	23	16	4375.87	561.80
71	Samsung 870 EVO 500GB	7	25	9	4276.46	612.81
72	Samsung T350	7	50	37	225.24	45.05
73	LG 24MK430	9	42	31	3642.10	177.10
74	Microsoft Basic	7	39	15	3280.57	352.79
75	Corsair HS50	5	37	32	2854.60	399.00
76	AOC 24B1XHS	8	36	36	1577.91	240.85
77	Seagate Expansion 1TB	8	34	22	1120.35	162.91
78	Samsung T5 500GB	7	20	17	4787.45	463.43
79	Dell SE2419HR	5	49	33	178.22	28.80
80	Seagate Expansion 1TB	6	33	22	2269.43	127.33
81	Intelbras XNB 600	8	32	14	603.57	30.16
82	Razer Kraken	8	50	48	1988.66	238.50
83	Redragon Kumara	5	47	39	3247.40	159.82
84	Samsung T5 500GB	7	44	38	4288.15	122.53
85	Philips 243V7	9	39	22	2212.29	259.60
86	WD Elements 2TB	6	34	30	210.20	31.76
87	Razer Kiyo	5	42	32	2235.54	234.55
88	Corsair HS50	10	31	21	1300.79	166.77
89	LG 24MK430	9	41	21	3215.87	51.36
90	Toshiba Canvio Basics	8	38	15	506.74	71.84
91	Asus VivoBook	8	50	20	1046.60	148.44
92	Samsung T5 500GB	5	23	21	2417.91	83.79
93	Crucial MX500	6	27	22	1840.44	246.21
94	Razer DeathAdder	8	20	11	1427.89	86.40
95	Dell WM126	5	32	15	1062.77	189.75
96	Dell Inspiron 15	9	47	9	1540.83	243.17
97	SanDisk Ultra 3D 500GB	5	31	22	2876.48	331.55
98	HP Pavilion x360	8	41	12	3603.20	469.32
99	TS Shara UPS	10	46	29	1728.75	130.29
100	Samsung 870 EVO 500GB	9	41	11	1743.52	217.28
6	WD Elements 2TB	9	38	22	1189.66	40.68
1	Microsoft Wired 600	7	45	42	4050.00	604.32
2	Razer Kiyo	8	44	29	4051.00	14.60
3	Logitech M170	10	41	29	4052.00	450.95
5	Dell Inspiron 15	9	30	10	1986.91	281.55
10	AOC 24B1XHS	7	50	19	3390.82	240.75
7	HyperX Cloud Stinger	6	48	11	4631.75	543.99
8	WD Elements 2TB	7	37	9	2974.63	25.43
4	Logitech H390	8	35	10	4407.95	301.02
101	Teclado Mecânico Gamer RGB HyperX Alloy FPS Pro	5	50	25	349.99	0.10
102	Mouse Gamer Óptico Logitech G502 HERO RGB	5	50	30	299.90	0.05
103	Monitor Gamer Samsung Odyssey G3 27" Full HD 144Hz	3	30	15	1499.00	0.15
104	Headset Gamer HyperX Cloud Stinger Core 7.1	10	100	60	249.99	0.08
105	Webcam Full HD Logitech C920S Pro	8	80	40	499.00	0.00
106	SSD Kingston A400 240GB SATA III	10	100	70	149.90	0.05
107	Memória RAM Kingston Fury Beast 8GB DDR4 3200MHz	10	100	80	189.90	0.03
108	Processador Intel Core i5-12400F LGA 1700	2	20	10	999.00	0.00
109	Placa de Vídeo NVIDIA GeForce RTX 3060 12GB	1	10	5	2599.00	0.07
110	Placa Mãe Gigabyte B660M AORUS Pro DDR4 LGA 1700	3	30	12	899.00	0.00
111	Fonte ATX Corsair CV550 550W 80 Plus Bronze	5	50	20	379.90	0.05
112	Gabinete Gamer Pichau Kazan 2 Lateral de Vidro	5	50	18	299.90	0.00
113	Roteador Wi-Fi 6 TP-Link Archer AX50 Dual Band	4	40	15	599.99	0.10
114	Impressora Multifuncional Epson EcoTank L3250 Tanque de Tinta	3	30	10	1199.00	0.05
115	Nobreak SMS Net Station 700VA Bivolt	5	50	22	499.00	0.00
116	HD Externo Seagate Expansion 1TB USB 3.0	8	80	45	329.90	0.03
117	Pendrive SanDisk Cruzer Blade 64GB USB 2.0	15	150	90	49.90	0.00
118	Cabo HDMI 2.0 2 Metros Fortrek	20	200	100	29.90	0.00
119	Adaptador Bluetooth USB 4.0 Comtac	15	150	75	39.90	0.00
120	Leitor de Cartões de Memória USB 3.0	10	100	50	59.90	0.00
121	Mouse Pad Gamer Grande Speed Corsair MM300	8	80	35	99.90	0.05
122	Câmera de Segurança Intelbras VIP 1230 B G4 Bullet IP	3	30	10	549.99	0.00
123	Fone de Ouvido Bluetooth JBL Tune 510BT	10	100	55	299.00	0.10
124	Caixa de Som Portátil JBL Go 3 Bluetooth	12	120	70	229.00	0.05
125	Smartwatch Xiaomi Mi Watch Lite	5	50	20	399.00	0.00
126	Tablet Samsung Galaxy Tab A8 10.5" 64GB	3	30	12	1699.00	0.07
127	Notebook Acer Aspire 5 Intel Core i5 8GB RAM 256GB SSD	1	10	5	3499.00	0.10
128	Chromecast Google TV 4K	4	40	18	399.00	0.00
129	Controle sem Fio Xbox Series X|S Carbon Black	5	50	25	479.90	0.05
130	Jogo para PC Cyberpunk 2077	7	70	30	199.00	0.00
131	Impressora 3D Creality Ender 3 V2	1	10	3	1599.00	0.00
132	Filamento PLA 1.75mm 1kg Branco	10	100	40	99.90	0.00
133	Cabo de Rede Cat6 5 Metros	20	200	120	19.90	0.00
134	Adaptador USB-C para HDMI	10	100	60	79.90	0.00
135	Microfone Gamer HyperX QuadCast S RGB	3	30	10	799.00	0.00
136	Cadeira Gamer Husky Gaming Tempest Preta	2	20	8	899.00	0.10
137	Kit Cooler Fan RGB 3 Unidades Rise Mode	5	50	20	149.90	0.00
138	Pasta Térmica Rise Mode Frost	15	150	90	29.90	0.00
139	Kit Ferramentas para Manutenção de PCs	8	80	30	129.90	0.00
140	Filtro de Linha Bivolt 6 Tomadas	10	100	50	69.90	0.00
141	Suporte para Monitor de Mesa Articulado	5	50	25	199.00	0.00
142	Ring Light LED 10 polegadas com Tripé	7	70	30	159.90	0.00
143	Smart Speaker Echo Dot 4ª Geração com Alexa	5	50	20	329.00	0.10
144	Fire TV Stick Lite Amazon	8	80	35	249.00	0.05
145	Câmera de Ação GoPro HERO10 Black	1	10	2	2999.00	0.00
146	Drone DJI Mini 3 Pro com RC	1	5	1	5999.00	0.00
147	Óculos de Realidade Virtual Oculus Quest 2 128GB	1	10	3	2499.00	0.00
148	Volante Gamer Logitech G29 Driving Force PS4/PC	2	20	5	1999.00	0.00
149	Simulador de Voo Microsoft Flight Simulator	5	50	15	249.00	0.00
150	Licença Microsoft Office 365 Personal Anual	10	100	40	199.00	0.00
151	Antivírus Norton 360 Deluxe 1 Ano 3 Dispositivos	10	100	50	129.90	0.00
152	Adaptador Wi-Fi USB TP-Link TL-WN821N	15	150	80	69.90	0.00
153	Placa de Rede Gigabit PCIe	8	80	30	99.90	0.00
154	Switch de Rede TP-Link TL-SF1005D 5 Portas	10	100	45	59.90	0.00
155	Servidor NAS Synology DiskStation DS220+	1	5	2	2199.00	0.00
156	Câmera IP Wi-Fi Interna Positivo Smart Home	5	50	20	189.90	0.00
157	Fechadura Digital Intelbras FR 101	3	30	10	699.00	0.00
158	Lâmpada Inteligente Positivo Smart Lâmpada Wi-Fi	10	100	60	89.90	0.00
159	Tomada Inteligente Smart Plug Wi-Fi	10	100	55	79.90	0.00
160	Controle Remoto Universal Inteligente	8	80	30	119.90	0.00
161	Sensor de Presença Smart Wi-Fi	10	100	40	99.90	0.00
162	Kit Alarme Residencial Inteligente	3	30	10	1299.00	0.00
163	Interfone Residencial HDL F8 NTL	5	50	20	179.90	0.00
164	Campainha Sem Fio Elgin	10	100	50	79.90	0.00
165	Sistema de Câmeras de Segurança CFTV 4 Canais	2	20	8	1899.00	0.00
166	DVR Stand Alone Intelbras MHDX 1004 Multi HD	3	30	12	649.00	0.00
167	Câmera Veicular Dash Cam Full HD	5	50	25	299.00	0.00
168	GPS Automotivo Garmin Drive 52	4	40	15	799.00	0.00
169	Transmissor FM Bluetooth Veicular	10	100	60	89.90	0.00
170	Carregador Veicular USB Duplo	15	150	80	49.90	0.00
171	Suporte Celular Veicular Magnético	20	200	100	34.90	0.00
172	Capa para Smartphone iPhone 13 Pro Max Transparente	10	100	70	59.90	0.00
173	Película de Vidro Temperado iPhone 13 Pro Max	15	150	90	29.90	0.00
174	Smart TV Samsung Crystal UHD 50 polegadas 4K	1	10	4	2899.00	0.00
175	Soundbar Samsung HW-A450/ZD 2.1 Canais	3	30	10	999.00	0.00
176	Projetor Portátil Epson PowerLite S41+ SVGA	2	20	6	2199.00	0.00
177	Tela de Projeção Retrátil 90 polegadas	1	10	3	599.00	0.00
178	Home Theater Philco PHT8000	2	20	5	1599.00	0.00
179	Aspirador de Pó Robô Multilaser HO041	3	30	10	999.00	0.00
180	Câmera de Segurança Externa Wi-Fi Intelbras IM3	4	40	15	499.00	0.00
181	Smartwatch Apple Watch SE GPS 40mm	2	20	8	1999.00	0.00
182	Fone de Ouvido Sem Fio Apple AirPods Pro	5	50	20	1399.00	0.00
183	Carregador Portátil Power Bank Samsung 10000mAh	8	80	40	149.90	0.00
184	Cabo Carregador USB-C para Lightning 1m	10	100	60	89.90	0.00
185	Hub USB 3.0 4 Portas	10	100	50	59.90	0.00
186	Adaptador de Rede USB para Ethernet	8	80	35	79.90	0.00
187	Extensor de Alcance Wi-Fi TP-Link TL-WA850RE	7	70	30	99.90	0.00
188	Repetidor Wi-Fi Dual Band Mercusys AC1200	6	60	25	129.90	0.00
189	Roteador Mesh TP-Link Deco M4 2 Unidades	2	20	7	799.00	0.00
190	Microfone de Lapela P2 para Celular	10	100	50	69.90	0.00
191	Tripé Flexível para Câmera/Celular	10	100	45	49.90	0.00
192	Suporte de Celular para Gravação de Vídeos	8	80	30	79.90	0.00
193	Lente Macro para Celular	5	50	20	119.90	0.00
194	Kit Limpeza para Telas e Eletrônicos	15	150	90	39.90	0.00
195	Spray Limpa Telas Anti Estático	10	100	60	29.90	0.00
196	Pano de Microfibra para Limpeza	20	200	120	14.90	0.00
197	Organizador de Cabos Velcro	25	250	150	19.90	0.00
198	Etiquetadora Eletrônica Brother PT-H110	3	30	10	179.90	0.00
199	Fita para Etiquetadora Brother TZe-231	8	80	40	49.90	0.00
200	Destruidora de Papel Aurora AS610C	2	20	5	299.00	0.00
201	Fragmentadora de Papel Multilaser OF012	3	30	8	349.00	0.00
202	Calculadora Científica Casio FX-82MS Plus	10	100	50	79.90	0.00
203	Calculadora Financeira HP 12c	2	20	5	399.00	0.00
204	Máquina de Contar Cédulas BR-2200	1	10	2	1199.00	0.00
205	Detector de Notas Falsas UV	5	50	20	99.90	0.00
206	Leitor de Código de Barras Elgin EL120	4	40	15	349.00	0.00
207	Impressora de Etiquetas Térmica Elgin L42PRO	2	20	7	899.00	0.00
\.


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda (id_venda, id_vendedor, id_cliente, data_venda, total, status) FROM stdin;
2	2	5	2025-04-24 20:31:32.744225	0.00	0
5	2	5	2025-04-24 21:21:28.987632	16893.35	0
\.


--
-- Data for Name: vendedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendedor (id_vendedor, nome, fone, email, data_nasc, salario, comissao) FROM stdin;
1	Carlos Andrade	47991234567         	carlos.andrade@email.com	1985-06-12	3200.00	2.50
2	Fernanda Silva	48996543210         	fernanda.silva@email.com	1990-03-25	3500.00	2.50
3	João Paulo	47999887766         	joao.paulo@email.com	1982-11-08	3100.00	2.50
4	Mariana Oliveira	48991234567         	mariana.oliveira@email.com	1995-01-15	3700.00	2.50
5	Rafael Costa	47997654321         	rafael.costa@email.com	1988-09-30	3300.00	2.50
\.


--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 20, true);


--
-- Name: produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_produto_seq', 207, true);


--
-- Name: venda_id_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_id_venda_seq', 5, true);


--
-- Name: vendedor_id_vendedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedor_id_vendedor_seq', 5, true);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: item_venda ivenda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT ivenda_pkey PRIMARY KEY (id_venda, id_produto);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id_produto);


--
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id_venda);


--
-- Name: vendedor vendedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id_vendedor);


--
-- Name: venda cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- Name: item_venda ivenda_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT ivenda_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- Name: item_venda ivenda_id_venda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT ivenda_id_venda_fkey FOREIGN KEY (id_venda) REFERENCES public.venda(id_venda);


--
-- Name: venda vendedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT vendedor FOREIGN KEY (id_vendedor) REFERENCES public.vendedor(id_vendedor);


--
-- PostgreSQL database dump complete
--

\unrestrict MkavkkqJPF1Vy0EQgDfJUbAMmm7dwlam5wORf24TBspiGlMUDdvq3zux1s1bDBx


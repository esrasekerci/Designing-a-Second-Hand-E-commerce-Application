/*
	==================================================================
	IS 503 - Spring 2024
	Term Project Schema
	Student names: Engin Kılınç
				   Esra Şekerci
	==================================================================
*/

CREATE DATABASE  IF NOT EXISTS engin_esra;

USE engin_esra;


-- Table structures

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME
);

CREATE TABLE Brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    brand_website VARCHAR(255)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    brand_id INT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    date_posted DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'available',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    buyer_id INT,
    seller_id INT,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    price DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (product_id, buyer_id, seller_id)
);

CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT NOT NULL,
    comment TEXT,
    date_posted DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    product_id INT,
    message_content TEXT,
    date_sent DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SellerInformation (
    seller_id INT PRIMARY KEY,
    total_sales INT DEFAULT 0,
    rating DECIMAL(3, 2) DEFAULT 0.00,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    verification_status VARCHAR(10) DEFAULT 'unverified',
    FOREIGN KEY (seller_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 	Insert initial data into the tables

INSERT INTO Users (username, email, password, full_name, address, phone) VALUES
('AltayUygur', 'altayugur@gmail.com', '5xng4c', 'Altay Uygur', 'Özkan Köyü,14, 3602, Emirdağ/ Afyonkarahisar, Türkiye', '+904886225300'),
('YalçinNazmi', 'yalcinnazmi@gmail.com', 'wqcuqa', 'Yalçin Nazmi', 'Küllüce Köyü,30, 24802, Tercan/Afyon, Türkiye', '+904888951370'),
('BeyzaVolkan', 'beyzavolkan@gmail.com', 'fzy8dm', 'Beyza Volkan', 'Mersin,20, 61300, Akçaabat/Adapazari, Türkiye', '+908504313568'),
('ÖztürkToker', 'ozturktoker@gmail.com', '5yd8ju', 'Öztürk Toker', 'Dalbahçe,16, 55500, Çarşamba/Bandirma, Türkiye', '+903327217643'),
('KadirBayrak', 'kadirbayrak@gmail.com', 'skbksp', 'Kadir Bayrak', 'Çivi Köyü,17, 5000, Merkez/Bursa, Türkiye', '+903240833298'),
('IrmakÜzümcü', 'irmakuzumcu@gmail.com', 'bz8s9n', 'Irmak Üzümcü', 'Gümüşsuyu Mah.,9, 2802, Samsat/Bursa, Türkiye', '+904880699480'),
('EserAtakan', 'eseratakan@gmail.com', '4w9r3d', 'Eser Atakan', 'Özgür,9, 35120, Karabağlar/Erdemli, Türkiye', '+905337942852'),
('MirayTop', 'miraytop@gmail.com', 'pt6kef', 'Miray Top', 'Haciibrahim Köyü,15, 37502, İnebolu/Burdur, Türkiye', '+905473755226'),
('EvrenKobal', 'evrenkobal@gmail.com', 'kjh2yg', 'Evren Kobal', 'Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye', '+905067680461'),
('IpekHamdi', 'ipekhamdi@gmail.com', 'jherva', 'Ipek Hamdi', 'Seydiköy Köyü,23, 43270, Merkez/Istanbul, Türkiye', '+904585564041'),
('SanemAyvaz', 'sanemayvaz@gmail.com', '57jxap', 'Sanem Ayvaz', 'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye', '+904880005663'),
('KaraErdinç', 'karaerdinc@gmail.com', 'rwqmap', 'Kara Erdinç', 'Dez,6, 30110, Merkez/Didim, Türkiye', '+902522013221'),
('EsenIrmak', 'esenirmak@gmail.com', '27brgt', 'Esen Irmak', 'Abdulvehap Küfrevi Mah.,29, 4500, Patnos/Istanbul, Türkiye', '+908111998354'),
('CivanÖrnek', 'civanornek@gmail.com', 'ewm9vv', 'Civan Örnek', 'Karabörk Köyü,35, 23852, Kovancilar/Mugla, Türkiye', '+902466758479'),
('BesteHeper', 'bestehepe@gmail.com', 'vzxh6k', 'Beste Heper', 'Alaçam,31, 55850, Kavak/Izmit, Türkiye', '+905948334598'),
('BanuGürsu', 'banugürsu@gmail.com', '57b2c5', 'Banu Gürsu', 'Aşağitoklu Köyü,20, 4802, Taşliçay/Edirne, Türkiye', '+903763334278'),
('EsraCaner', 'esracaner@gmail.com', '5mtmyu', 'Esra Caner', 'Karagöz,8, 44210, Battalgazi/Yalova, Türkiye', '+904581921338'),
('KadirSözen', 'kadirsozen@gmail.com', '8u39nz', 'Kadir Sözen', 'Karabucak,12, 7570, Demre/Antakya, Türkiye', '+904666623539'),
('MetinAlkan', 'metinalkan@gmail.com', 'jeptnz', 'Metin Alkan', 'Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye', '+905551144780'),
('BerilKoçak', 'berilkocak@gmail.com', 'nzt4tm', 'Beril Koçak', 'Civreyil,32, 57402, Ayancik/Istanbul, Türkiye', '+904240959892'),
('GamzeÖrnek', 'gamzeornek@gmail.com', 'jdycmd', 'Gamze Örnek', 'Tabakhane,14, 16900, Yenişehir/Canakkale, Türkiye', '+905430687682'),
('AhmetKara', 'ahmet.kara@gmail.com', 't9l27w', 'Ahmet Kara', 'Kıbrıs Cad., No: 23, Dikili/Balıkesir, Türkiye', '+905553324567'),
('AyşeYılmaz', 'ayse.yilmaz@gmail.com', '72gptd', 'Ayşe Yılmaz', 'Yıldırım Mah., Atatürk Cad., No: 45, Zeytinburnu/Ankara, Türkiye', '+905444786123'),
('MehmetDemir', 'mehmet.demir@gmail.com', 'e94kft', 'Mehmet Demir', 'Fatih Mah., Gazi Cad., No: 78, Üsküdar/Ankara, Türkiye', '+905568975432'),
('FatmaÖztürk', 'fatma.ozturk@gmail.com', 'p5x8sq', 'Fatma Öztürk', 'Atatürk Bulv., No: 12, Bornova/Izmir, Türkiye', '+905512367890'),
('MustafaYıldız', 'mustafa.yildiz@gmail.com', 'qf5dp2', 'Mustafa Yıldız', 'Cemil Meriç Cad., No: 34, Çankaya/Adana, Türkiye', '+905323476589'),
('ZeynepKılıç', 'zeynep.kilic@gmail.com', '64m9nr', 'Zeynep Kılıç', 'Yavuz Selim Mah., 1003 Sok., No: 7, Çorlu/Bursa, Türkiye', '+905463218745'),
('EmineÖzdemir', 'emine.ozdemir@gmail.com', 'w7pjsq', 'Emine Özdemir', 'Bahçelievler Mah., Atatürk Cad., No: 56, Kepez/Ankara, Türkiye', '+905330945678'),
('AliYavuz', 'ali.yavuz@gmail.com', 'xvk3gp', 'Ali Yavuz', 'Barbaros Mah., Çınar Cad., No: 89, Maltepe/Kayseri, Türkiye', '+905554789012'),
('HavvaAydın', 'havva.aydin@gmail.com', 'k6g4mx', 'Havva Aydın', 'Yunus Emre Cad., No: 21, Sarıyer/Balıkesir, Türkiye', '+905418905432'),
('MuratArslan', 'murat.arslan@gmail.com', 't4d7sw', 'Murat Arslan', 'Güzel Sanatlar Mah., Ali İhsan Göğüş Cad., No: 33, Zeytinburnu/Manisa, Türkiye', '+905547834567'),
('HaticeKurt', 'hatice.kurt@gmail.com', 'f9msq2', 'Hatice Kurt', 'Mimarsinan Mah., 2021 Sok., No: 10, Bağcılar/Konya, Türkiye', '+905549876543'),
('İbrahimGüneş', 'ibrahim.gunes@gmail.com', 'b6z5nf', 'İbrahim Güneş', 'Çamlık Mah., Mehmet Akif Ersoy Cad., No: 5, Karabağlar/Kocaeli, Türkiye', '+905558762349'),
('SalihaŞahin', 'saliha.sahin@gmail.com', 't8jzvq', 'Saliha Şahin', 'Aşağı Mah., Atatürk Bulv., No: 22, Muratpaşa/Elazığ, Türkiye', '+905523467890'),
('YusufAvcı', 'yusuf.avci@gmail.com', 'p6mdtn', 'Yusuf Avcı', 'İstasyon Mah., 2023 Sok., No: 15, Merkez/Gaziantep, Türkiye', '+905531234567'),
('SultanKaya', 'sultan.kaya@gmail.com', 'm8b4jd', 'Sultan Kaya', 'Kurtuluş Mah., 1080 Sok., No: 30, İzmit/Aydın, Türkiye', '+905536789012'),
('OsmanBulut', 'osman.bulut@gmail.com', '7prkxm', 'Osman Bulut', 'Gazi Mah., Zafer Cad., No: 11, Osmangazi/Kütahya, Türkiye', '+905547098765'),
('HafizePolat', 'hafize.polat@gmail.com', 'n5gj2t', 'Hafize Polat', 'Maraşal Fevzi Çakmak Mah., Zübeyde Hanım Cad., No: 45, Karşıyaka/Sakarya, Türkiye', '+905541234567'),
('İsmailÖzkan', 'ismail.ozkan@gmail.com', 't3vrj9', 'İsmail Özkan', 'Balkan Mah., Atatürk Bulv., No: 8, Nilüfer/Çorum, Türkiye', '+905550987654'),
('YeterKoç', 'yeter.koc@gmail.com', 'x5f7mr', 'Yeter Koç', 'Erenler Mah., Gaziantep Cad., No: 14, Seyhan/Artvin, Türkiye', '+905561234567'),
('MustafaAksoy', 'mustafa.aksoy@gmail.com', 'n2kx8v', 'Mustafa Aksoy', 'Büyükşehir Mah., 3026 Sok., No: 25, Etimesgut/Trabzon, Türkiye', '+905548901234'),
('AynurDemirci', 'aynur.demirci@gmail.com', '9m6p3t', 'Aynur Demirci', 'Bilge Mah., Mustafa Kemal Paşa Cad., No: 28, Mamak/Sivas, Türkiye', '+905548765432'),
('YusufBudak', 'yusuf.budak@gmail.com', 'b9kx8z', 'Yusuf Budak', 'Bahçelievler Mah., Turgut Reis Cad., No: 16, Akşehir/Adıyaman, Türkiye', '+905557654321'),
('HüseyinAslan', 'huseyin.aslan@gmail.com', 'm3kv75', 'Hüseyin Aslan', 'Fatih Mah., Mimar Sinan Cad., No: 12, Gürpınar/Afyonkarahisar, Türkiye', '+905558741515'),
('NurKoç', 'nur.koc@gmail.com', '4w9s3t', 'Nur Koç', 'Atatürk Mah., İnönü Cad., No: 7, Esenyurt/Trabzon, Türkiye', '+905556789012'),
('AliÖztürk', 'ali.ozturk@gmail.com', 'k7b3zm', 'Ali Öztürk', 'Çamlıca Mah., Cumhuriyet Cad., No: 10, Ümraniye/Mardin, Türkiye', '+905523456789'),
('NecmiyeYılmaz', 'necmiye.yilmaz@gmail.com', 'z5m9nx', 'Necmiye Yılmaz', 'Merkez Mah., Akasya Sok., No: 22, Beyoğlu/Zonguldak, Türkiye', '+905541234567'),
('RamazanKaya', 'ramazan.kaya@gmail.com', 't6n7vk', 'Ramazan Kaya', 'Feke Mah., Gültepe Cad., No: 15, Çaycuma/Aksaray, Türkiye', '+905556789012'),
('RabiaŞahin', 'rabia.sahin@gmail.com', 'p8x5mk', 'Rabia Şahin', 'Güzelyurt Mah., Talatpaşa Cad., No: 9, Ümraniye/Karaman, Türkiye', '+905536789012'),
('BurakKurt', 'burak.kurt@gmail.com', 'm9p6sc', 'Burak Kurt', 'Yenidoğan Mah., Gazi Cad., No: 25, Çubuk/Kastamonu, Türkiye', '+905550987654');

INSERT INTO Brands (brand_name, brand_website) VALUES
('Zara', 'http://www.zara.com'),
('Defacto', 'http://www.defacto.com'),
('Koton', 'http://www.koton.com'),
('Sarar', 'http://www.sarar.com'),
('H&M', 'http://www.h&m.com'),
('Mango', 'http://www.mango.com');

INSERT INTO Products (user_id, brand_id, product_name, description, price) VALUES
(11, 3, 'Tişört', 'Kırmızı Tişört', 150.00),
(20, 5, 'Kapüşonlu', 'Gri Kapüşonlu', 200.00),
(3, 2, 'Polo Yaka', 'Mavi Polo Yaka', 175.00),
(8, 4, 'Ceket', 'Siyah Deri Ceket', 450.00),
(21, 1, 'Gömlek', 'Beyaz Pamuk Gömlek', 130.00),
(13, 3, 'Kazak', 'Yeşil Yün Kazak', 220.00),
(12, 2, 'Elbise', 'Sarı Yazlık Elbise', 180.00),
(14, 5, 'Bluz', 'Mor Saten Bluz', 190.00),
(5, 5, 'Pantolon', 'Kahverengi Kadife Pantolon', 160.00),
(3, 3, 'Şort', 'Turuncu Spor Şort', 110.00),
(2, 2, 'Üst', 'Pembe Dantel Üst', 140.00),
(3, 3, 'Kot', 'Lacivert Kot Pantolon', 210.00),
(11, 2, 'Kaban', 'Bej Trençkot', 350.00),
(14, 1, 'Üst', 'Turkuaz Atlet', 120.00),
(15, 4, 'Hırka', 'Bordo Hırka', 170.00),
(17, 4, 'Etek', 'Gümüş Payetli Etek', 230.00),
(2, 1, 'Pantolon', 'Altın Renkli Pantolon', 250.00),
(3, 2, 'Şal', 'Camgöbeği İpek Şal', 90.00),
(3, 4, 'Şapka', 'Lavanta Örgü Şapka', 60.00),
(7, 4, 'Elbise', 'Bordo Kadife Elbise', 270.00),
(7, 1, 'Pantolon', 'Haki Yeşil Kargo Pantolon', 180.00),
(11, 1, 'Kazak', 'Koyu Gri Kazak', 200.00),
(5, 3, 'Gömlek', 'Fildişi Renkli Düğmeli Gömlek', 130.00),
(13, 3, 'Blazer', 'Hardal Sarısı Blazer', 300.00),
(13, 3, 'Üst', 'Mercan Peplum Üst', 160.00),
(21, 2, 'Şort', 'Açık Mavi Yüzme Şortu', 100.00),
(7, 2, 'Elbise', 'Şarap Kırmızısı Maxi Elbise', 250.00),
(38, 1, 'Üst', 'Magenta Omzu Açık Üst', 150.00),
(12, 5, 'Ceket', 'Haki Kullanışlı Ceket', 320.00),
(3, 4, 'Gömlek', 'Nane Yeşili Polo Gömlek', 140.00),
(42, 3, 'Kapri Pantolon', 'Siyah Pamuklu Kapri Pantolon', 120.00),
(38, 2, 'Eşofman Takımı', 'Mavi Kadife Eşofman Takımı', 280.00),
(22, 4, 'Hırka', 'Sarı Örme Hırka', 150.00),
(49, 5, 'Etek', 'Pembe Koton Etek', 110.00),
(21, 6, 'Tişört', 'Gri Baskılı Tişört', 90.00),
(14, 3, 'Elbise', 'Beyaz İpek Elbise', 320.00),
(38, 2, 'Pantolon', 'Lacivert Keten Pantolon', 170.00),
(13, 4, 'Ceket', 'Kahverengi Kürk Ceket', 420.00),
(38, 5, 'Gömlek', 'Mor Ekose Gömlek', 130.00),
(3, 3, 'Sweatshirt', 'Bordo Kapüşonlu Sweatshirt', 180.00),
(49, 2, 'Elbise', 'Pudra Rengi Kadife Elbise', 260.00),
(13, 1, 'Pantolon', 'Siyah Deri Skinny Pantolon', 230.00),
(49, 6, 'Kaban', 'Koyu Mavi Düz Kaban', 370.00),
(42, 3, 'Kazak', 'Mürdüm Renkli Triko Kazak', 200.00),
(15, 5, 'Bluz', 'Beyaz Dantelli Bluz', 140.00),
(13, 2, 'Şort', 'Lila Şifon Şort', 100.00),
(29, 6, 'Gömlek', 'Somon Renkli Salaş Gömlek', 120.00),
(29, 3, 'Tunik', 'Gri Desenli Tunik', 150.00),
(20, 4, 'Ceket', 'Yeşil Kürklü Ceket', 400.00),
(13, 6, 'Etek', 'Turuncu İspanyol Etek', 180.00),
(36, 2, 'Pantolon', 'Beyaz Kanvas Pantolon', 160.00),
(25, 1, 'Elbise', 'Saks Mavisi Kolsuz Elbise', 210.00),
(32, 3, 'Bluz', 'Pembe İpek Bluz', 190.00),
(29, 4, 'Kaban', 'Açık Gri Kışlık Kaban', 350.00),
(36, 6, 'Sarı', 'Sarı Şapka', 100.00);

INSERT INTO Transactions (product_id, buyer_id, seller_id, price, shipping_address, status) VALUES
(1, 7, 11, 150.00, 'Özgür,9, 35120, Karabağlar/Erdemli, Türkiye', 'completed'),
(2, 18, 20, 200.00, 'Karabucak,12, 7570, Demre/Antakya, Türkiye', 'completed'),
(3, 15, 3, 175.00, 'Alaçam,31, 55850, Kavak/Izmit, Türkiye', 'pending'),
(5, 40, 21, 130.00, 'Erenler Mah., Gaziantep Cad., No: 14, Seyhan/Artvin, Türkiye', 'completed'),
(9, 9, 5, 160.00, 'Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye', 'pending'),
(10, 5, 3, 110.00, 'Çivi Köyü,17, 5000, Merkez/Bursa', 'completed'),
(11, 7, 2, 140.00, 'Özgür,9, 35120, Karabağlar/Erdemli, Türkiye', 'completed'),
(12, 23, 3, 210.00, 'Yıldırım Mah., Atatürk Cad., No: 45, Zeytinburnu/Ankara, Türkiye', 'pending'),
(13, 11, 11, 350.00, 'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye', 'completed'),
(14, 11, 11, 120.00, 'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul', 'pending'),
(16, 14, 17, 230.00, 'Karabörk Köyü,35, 23852, Kovancilar/Mugla', 'completed'),
(18, 9, 3, 90.00, 'Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye', 'completed'),
(19, 18, 3, 60.00, 'Karabucak,12, 7570, Demre/Antakya, Türkiye', 'completed'),
(20, 18, 6, 270.00, 'Karabucak,12, 7570, Demre/Antakya, Türkiye', 'completed'),
(22, 19, 1, 200.00, 'Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye', 'completed'),
(26, 2, 21, 100.00, 'Küllüce Köyü,30, 24802, Tercan/Afyon, Türkiye', 'completed'),
(27, 15, 7, 250.00, 'Alaçam,31, 55850, Kavak/Izmit, Türkiye', 'completed'),
(29, 19, 12, 320.00, 'Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye', 'pending'),
(31, 11, 42, 120.00, 'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye', 'completed'),
(42, 33, 13, 230.00, 'Çamlık Mah., Mehmet Akif Ersoy Cad., No: 5, Karabağlar/Kocaeli, Türkiye', 'completed'),
(44, 37, 42, 200.00, 'Gazi Mah., Zafer Cad., No: 11, Osmangazi/Kütahya, Türkiye', 'pending');

INSERT INTO Reviews (product_id, user_id, rating, comment) VALUES
(1, 7, 5, 'Tişört beklediğimden daha kaliteli çıktı. Satıcı çok yardımcıydı ve kargo hızlı geldi. Tavsiye ederim."'),
(2, 18, 5, 'Kapüşonlu çok güzel, tam bedenime uygun. Satıcı çok nazikti ve kargo hızlıydı.'),
(5, 40, 3, 'Kargo gecikti ve satıcı sorularımı geç cevapladı. Gömlek fena değil.'),
(10, 5, 5, 'Şort çok güzel ve kaliteli. Satıcı ilgiliydi ve kargo zamanında geldi.'),
(11, 7, 5, 'Ürün gayet güzel, satıcı da çok yardımcı oldu. Kargo hızlıydı.'),
(13, 11, 4, 'Kıyafet güzel ama kargo çok gecikti. Satıcı da yardımcı oldu.'),
(16, 14, 3, 'Ürün biraz büyük geldi ama kalite çok iyi. Satıcı kibar, kargo zamanında.'),
(18, 9, 2, 'Kargo çok geç geldi ve kıyafet istediğim gibi değildi. Satıcıya ulaşmak zor oldu.'),
(19, 18, 1, 'Ürün fotoğraftakinden farklı geldi, satıcı da çok ilgisizdi.'),
(20, 18, 2, 'Kıyafet kötü kokuyordu, satıcı ilgisizdi. Kargo iyiydi.'),
(22, 19, 4, 'İdare eder, daha az kullanılmışş olmasını bekliyordu.'),
(26, 2, 5, 'Kıyafet harika, tam bedenime göre. Satıcı çok yardımcı oldu. Kargo hızlıydı.'),
(27, 15, 1, 'Elbisenin kırmızı rengi soluktu, hiç beğenmedim. Satıcı da hiç yardımcı olmadı.'),
(31, 11, 4, 'Kabanı çok beğendim, ama ürün elime 20 günde ulaştı. Bir puanı o nedenle kırıyorum.'),
(42, 33, 5, 'Her şey çok iyiydi, teşekkür ederim.');

INSERT INTO Messages (sender_id, receiver_id, product_id, message_content) VALUES
(13, 11, 1, 'Selam, ürün hala mevcut mu?'),
(9, 5, 9, 'Selam, ürünü ne zaman gönderebilirsiniz? Acil bir ihtiyacım var, mümkünse hızlı kargoyla gönderim yapabilir misiniz?'),
(5, 9, 9, 'Tabii efendim, ürününüzü bugün kargoya veriyoruz, en kısa sürede elinize ulaşır.'),
(19, 12, 29, 'Merhaba, kargo süresi beklediğimden biraz uzun sürdü. Bu konuda bir açıklamanız var mı?'),
(12, 19, 29, 'Ürününüz kargoya siparişin oluştuğu gün verilmiştir, kargo şirketindeki yoğunluktan dolayı gecikme yaşamış olabilirsiniz.'),
(19, 1, 22, 'Selam, ürün geldi ancak rengi fotoğraftakinden farklı. İade veya değişim için nasıl bir yol izlemeliyim?'),
(9, 3, 18, 'Selam, ürünü bugün teslim aldım. Harika görünüyor, teşekkür ederim!'),
(3, 9, 18, 'Memnun kaldığınız için çok memnunum, iyi günlerde kullanın :).'),
(21, 10, 30, 'Merhaba, ürünün son fiyatı nedir? Bir miktar indirim yapabilir misiniz?'),
(14, 17, 16, 'Merhaba, ürün geldi ancak dikişlerinde ufak bir sorun var. Bu konuda nasıl bir çözüm bulabiliriz?'),
(17, 14, 16, 'Memnun kalmadığınız ürünü 30 gün içerisinde iade edebilirsiniz.'),
(20, 3, 12, 'Ürün kaç günde elime ulaşır?');

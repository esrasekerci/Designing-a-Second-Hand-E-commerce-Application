-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: engin_esra
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `brand_id` int NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(100) NOT NULL,
  `brand_website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Zara','http://www.zara.com'),(2,'Defacto','http://www.defacto.com'),(3,'Koton','http://www.koton.com'),(4,'Sarar','http://www.sarar.com'),(5,'H&M','http://www.h&m.com'),(6,'Mango','http://www.mango.com');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `message_content` text,
  `date_sent` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,13,11,1,'Selam, ürün hala mevcut mu?','2024-05-25 20:44:48'),(2,9,5,9,'Selam, ürünü ne zaman gönderebilirsiniz? Acil bir ihtiyacım var, mümkünse hızlı kargoyla gönderim yapabilir misiniz?','2024-05-25 20:44:48'),(3,5,9,9,'Tabii efendim, ürününüzü bugün kargoya veriyoruz, en kısa sürede elinize ulaşır.','2024-05-25 20:44:48'),(4,19,12,29,'Merhaba, kargo süresi beklediğimden biraz uzun sürdü. Bu konuda bir açıklamanız var mı?','2024-05-25 20:44:48'),(5,12,19,29,'Ürününüz kargoya siparişin oluştuğu gün verilmiştir, kargo şirketindeki yoğunluktan dolayı gecikme yaşamış olabilirsiniz.','2024-05-25 20:44:48'),(6,19,1,22,'Selam, ürün geldi ancak rengi fotoğraftakinden farklı. İade veya değişim için nasıl bir yol izlemeliyim?','2024-05-25 20:44:48'),(7,9,3,18,'Selam, ürünü bugün teslim aldım. Harika görünüyor, teşekkür ederim!','2024-05-25 20:44:48'),(8,3,9,18,'Memnun kaldığınız için çok memnunum, iyi günlerde kullanın :).','2024-05-25 20:44:48'),(9,21,10,30,'Merhaba, ürünün son fiyatı nedir? Bir miktar indirim yapabilir misiniz?','2024-05-25 20:44:48'),(10,14,17,16,'Merhaba, ürün geldi ancak dikişlerinde ufak bir sorun var. Bu konuda nasıl bir çözüm bulabiliriz?','2024-05-25 20:44:48'),(11,17,14,16,'Memnun kalmadığınız ürünü 30 gün içerisinde iade edebilirsiniz.','2024-05-25 20:44:48'),(12,20,3,12,'Ürün kaç günde elime ulaşır?','2024-05-25 20:44:48');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `date_posted` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'available',
  PRIMARY KEY (`product_id`),
  KEY `user_id` (`user_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,11,3,'Tişört','Kırmızı Tişört',150.00,'2024-05-25 20:44:48','sold'),(2,20,5,'Kapüşonlu','Gri Kapüşonlu',200.00,'2024-05-25 20:44:48','sold'),(3,3,2,'Polo Yaka','Mavi Polo Yaka',175.00,'2024-05-25 20:44:48','reserved'),(4,8,4,'Ceket','Siyah Deri Ceket',450.00,'2024-05-25 20:44:48','available'),(5,21,1,'Gömlek','Beyaz Pamuk Gömlek',130.00,'2024-05-25 20:44:48','sold'),(6,13,3,'Kazak','Yeşil Yün Kazak',220.00,'2024-05-25 20:44:48','available'),(7,12,2,'Elbise','Sarı Yazlık Elbise',180.00,'2024-05-25 20:44:48','available'),(8,14,5,'Bluz','Mor Saten Bluz',190.00,'2024-05-25 20:44:48','available'),(9,5,5,'Pantolon','Kahverengi Kadife Pantolon',160.00,'2024-05-25 20:44:48','reserved'),(10,3,3,'Şort','Turuncu Spor Şort',110.00,'2024-05-25 20:44:48','sold'),(11,2,2,'Üst','Pembe Dantel Üst',140.00,'2024-05-25 20:44:48','sold'),(12,3,3,'Kot','Lacivert Kot Pantolon',210.00,'2024-05-25 20:44:48','reserved'),(13,11,2,'Kaban','Bej Trençkot',350.00,'2024-05-25 20:44:48','sold'),(14,14,1,'Üst','Turkuaz Atlet',120.00,'2024-05-25 20:44:48','reserved'),(15,15,4,'Hırka','Bordo Hırka',170.00,'2024-05-25 20:44:48','available'),(16,17,4,'Etek','Gümüş Payetli Etek',230.00,'2024-05-25 20:44:48','sold'),(17,2,1,'Pantolon','Altın Renkli Pantolon',250.00,'2024-05-25 20:44:48','available'),(18,3,2,'Şal','Camgöbeği İpek Şal',90.00,'2024-05-25 20:44:48','sold'),(19,3,4,'Şapka','Lavanta Örgü Şapka',60.00,'2024-05-25 20:44:48','sold'),(20,7,4,'Elbise','Bordo Kadife Elbise',270.00,'2024-05-25 20:44:48','sold'),(21,7,1,'Pantolon','Haki Yeşil Kargo Pantolon',180.00,'2024-05-25 20:44:48','available'),(22,11,1,'Kazak','Koyu Gri Kazak',200.00,'2024-05-25 20:44:48','sold'),(23,5,3,'Gömlek','Fildişi Renkli Düğmeli Gömlek',130.00,'2024-05-25 20:44:48','available'),(24,13,3,'Blazer','Hardal Sarısı Blazer',300.00,'2024-05-25 20:44:48','available'),(25,13,3,'Üst','Mercan Peplum Üst',160.00,'2024-05-25 20:44:48','available'),(26,21,2,'Şort','Açık Mavi Yüzme Şortu',100.00,'2024-05-25 20:44:48','sold'),(27,7,2,'Elbise','Şarap Kırmızısı Maxi Elbise',250.00,'2024-05-25 20:44:48','sold'),(28,38,1,'Üst','Magenta Omzu Açık Üst',150.00,'2024-05-25 20:44:48','available'),(29,12,5,'Ceket','Haki Kullanışlı Ceket',320.00,'2024-05-25 20:44:48','reserved'),(30,3,4,'Gömlek','Nane Yeşili Polo Gömlek',140.00,'2024-05-25 20:44:48','available'),(31,42,3,'Kapri Pantolon','Siyah Pamuklu Kapri Pantolon',120.00,'2024-05-25 20:44:48','sold'),(32,38,2,'Eşofman Takımı','Mavi Kadife Eşofman Takımı',280.00,'2024-05-25 20:44:48','available'),(33,22,4,'Hırka','Sarı Örme Hırka',150.00,'2024-05-25 20:44:48','available'),(34,49,5,'Etek','Pembe Koton Etek',110.00,'2024-05-25 20:44:48','available'),(35,21,6,'Tişört','Gri Baskılı Tişört',90.00,'2024-05-25 20:44:48','available'),(36,14,3,'Elbise','Beyaz İpek Elbise',320.00,'2024-05-25 20:44:48','available'),(37,38,2,'Pantolon','Lacivert Keten Pantolon',170.00,'2024-05-25 20:44:48','available'),(38,13,4,'Ceket','Kahverengi Kürk Ceket',420.00,'2024-05-25 20:44:48','available'),(39,38,5,'Gömlek','Mor Ekose Gömlek',130.00,'2024-05-25 20:44:48','available'),(40,3,3,'Sweatshirt','Bordo Kapüşonlu Sweatshirt',180.00,'2024-05-25 20:44:48','available'),(41,49,2,'Elbise','Pudra Rengi Kadife Elbise',260.00,'2024-05-25 20:44:48','available'),(42,13,1,'Pantolon','Siyah Deri Skinny Pantolon',230.00,'2024-05-25 20:44:48','sold'),(43,49,6,'Kaban','Koyu Mavi Düz Kaban',370.00,'2024-05-25 20:44:48','available'),(44,42,3,'Kazak','Mürdüm Renkli Triko Kazak',200.00,'2024-05-25 20:44:48','reserved'),(45,15,5,'Bluz','Beyaz Dantelli Bluz',140.00,'2024-05-25 20:44:48','available'),(46,13,2,'Şort','Lila Şifon Şort',100.00,'2024-05-25 20:44:48','available'),(47,29,6,'Gömlek','Somon Renkli Salaş Gömlek',120.00,'2024-05-25 20:44:48','available'),(48,29,3,'Tunik','Gri Desenli Tunik',150.00,'2024-05-25 20:44:48','available'),(49,20,4,'Ceket','Yeşil Kürklü Ceket',400.00,'2024-05-25 20:44:48','available'),(50,13,6,'Etek','Turuncu İspanyol Etek',180.00,'2024-05-25 20:44:48','available'),(51,36,2,'Pantolon','Beyaz Kanvas Pantolon',160.00,'2024-05-25 20:44:48','available'),(52,25,1,'Elbise','Saks Mavisi Kolsuz Elbise',210.00,'2024-05-25 20:44:48','available'),(53,32,3,'Bluz','Pembe İpek Bluz',190.00,'2024-05-25 20:44:48','available'),(54,29,4,'Kaban','Açık Gri Kışlık Kaban',350.00,'2024-05-25 20:44:48','available'),(55,36,6,'Sarı','Sarı Şapka',100.00,'2024-05-25 20:44:48','available');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `date_posted` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,7,5,'Tişört beklediğimden daha kaliteli çıktı. Satıcı çok yardımcıydı ve kargo hızlı geldi. Tavsiye ederim.\"','2024-05-25 20:44:48'),(2,2,18,5,'Kapüşonlu çok güzel, tam bedenime uygun. Satıcı çok nazikti ve kargo hızlıydı.','2024-05-25 20:44:48'),(3,5,40,3,'Kargo gecikti ve satıcı sorularımı geç cevapladı. Gömlek fena değil.','2024-05-25 20:44:48'),(4,10,5,5,'Şort çok güzel ve kaliteli. Satıcı ilgiliydi ve kargo zamanında geldi.','2024-05-25 20:44:48'),(5,11,7,5,'Ürün gayet güzel, satıcı da çok yardımcı oldu. Kargo hızlıydı.','2024-05-25 20:44:48'),(6,13,11,4,'Kıyafet güzel ama kargo çok gecikti. Satıcı da yardımcı oldu.','2024-05-25 20:44:48'),(7,16,14,3,'Ürün biraz büyük geldi ama kalite çok iyi. Satıcı kibar, kargo zamanında.','2024-05-25 20:44:48'),(8,18,9,2,'Kargo çok geç geldi ve kıyafet istediğim gibi değildi. Satıcıya ulaşmak zor oldu.','2024-05-25 20:44:48'),(9,19,18,1,'Ürün fotoğraftakinden farklı geldi, satıcı da çok ilgisizdi.','2024-05-25 20:44:48'),(10,20,18,2,'Kıyafet kötü kokuyordu, satıcı ilgisizdi. Kargo iyiydi.','2024-05-25 20:44:48'),(11,22,19,4,'İdare eder, daha az kullanılmışş olmasını bekliyordu.','2024-05-25 20:44:48'),(12,26,2,5,'Kıyafet harika, tam bedenime göre. Satıcı çok yardımcı oldu. Kargo hızlıydı.','2024-05-25 20:44:48'),(13,27,15,1,'Elbisenin kırmızı rengi soluktu, hiç beğenmedim. Satıcı da hiç yardımcı olmadı.','2024-05-25 20:44:48'),(14,31,11,4,'Kabanı çok beğendim, ama ürün elime 20 günde ulaştı. Bir puanı o nedenle kırıyorum.','2024-05-25 20:44:48'),(15,42,33,5,'Her şey çok iyiydi, teşekkür ederim.','2024-05-25 20:44:48');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `enforce_review_on_completed_transaction` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE transaction_status VARCHAR(20);

    -- Check if there is a completed transaction for the buyer and product
    SELECT status INTO transaction_status
    FROM Transactions
    WHERE product_id = NEW.product_id
        AND buyer_id = NEW.user_id
    LIMIT 1;

    -- If no transaction found or status is not completed, raise an error
    IF transaction_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add review: No transaction found for this product';
    ELSEIF transaction_status != 'completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add review: Transaction is not completed for this product';
    END IF;

    -- Check if the product already has a review from the buyer
    IF EXISTS (
        SELECT 1
        FROM Reviews
        WHERE product_id = NEW.product_id
            AND user_id = NEW.user_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add review: Already reviewed this product';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_insert` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE avg_rating DECIMAL(5, 2);
    DECLARE review_count INT;

    -- Count the number of reviews for the seller's products with completed transactions
    SET review_count = (
        SELECT COUNT(*)
        FROM Reviews r
        JOIN Products p ON r.product_id = p.product_id
        JOIN Transactions t ON p.product_id = t.product_id
        WHERE t.seller_id = (
            SELECT user_id FROM Products WHERE product_id = NEW.product_id
        )
        AND t.status = 'completed'
    );

    -- Calculate the average rating if reviews exist
    IF review_count > 0 THEN
        SET avg_rating = (
            SELECT AVG(r.rating)
            FROM Reviews r
            JOIN Products p ON r.product_id = p.product_id
            JOIN Transactions t ON p.product_id = t.product_id
            WHERE t.seller_id = (
                SELECT user_id FROM Products WHERE product_id = NEW.product_id
            )
            AND t.status = 'completed'
        );
    ELSE
        SET avg_rating = 0.00;
    END IF;

    -- Update the SellerInformation table with the new average rating
    UPDATE SellerInformation
    SET rating = avg_rating
    WHERE seller_id = (
        SELECT user_id FROM Products WHERE product_id = NEW.product_id
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sellerinformation`
--

DROP TABLE IF EXISTS `sellerinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellerinformation` (
  `seller_id` int NOT NULL,
  `total_sales` int DEFAULT '0',
  `rating` decimal(3,2) DEFAULT '0.00',
  `join_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `verification_status` varchar(10) DEFAULT 'unverified',
  PRIMARY KEY (`seller_id`),
  CONSTRAINT `sellerinformation_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellerinformation`
--

LOCK TABLES `sellerinformation` WRITE;
/*!40000 ALTER TABLE `sellerinformation` DISABLE KEYS */;
INSERT INTO `sellerinformation` VALUES (1,1,0.00,'2024-05-25 20:44:48','unverified'),(2,1,5.00,'2024-05-25 20:44:48','unverified'),(3,3,2.67,'2024-05-25 20:44:48','verified'),(6,1,0.00,'2024-05-25 20:44:48','unverified'),(7,1,1.00,'2024-05-25 20:44:48','unverified'),(11,2,4.50,'2024-05-25 20:44:48','unverified'),(13,1,5.00,'2024-05-25 20:44:48','unverified'),(17,1,3.00,'2024-05-25 20:44:48','unverified'),(20,1,5.00,'2024-05-25 20:44:48','unverified'),(21,2,4.00,'2024-05-25 20:44:48','unverified'),(42,1,4.00,'2024-05-25 20:44:48','unverified');
/*!40000 ALTER TABLE `sellerinformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `price` decimal(10,2) NOT NULL,
  `shipping_address` text,
  `status` varchar(20) DEFAULT 'pending',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `product_id` (`product_id`,`buyer_id`,`seller_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,7,11,'2024-05-25 20:44:48',150.00,'Özgür,9, 35120, Karabağlar/Erdemli, Türkiye','completed'),(2,2,18,20,'2024-05-25 20:44:48',200.00,'Karabucak,12, 7570, Demre/Antakya, Türkiye','completed'),(3,3,15,3,'2024-05-25 20:44:48',175.00,'Alaçam,31, 55850, Kavak/Izmit, Türkiye','pending'),(4,5,40,21,'2024-05-25 20:44:48',130.00,'Erenler Mah., Gaziantep Cad., No: 14, Seyhan/Artvin, Türkiye','completed'),(5,9,9,5,'2024-05-25 20:44:48',160.00,'Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye','pending'),(6,10,5,3,'2024-05-25 20:44:48',110.00,'Çivi Köyü,17, 5000, Merkez/Bursa','completed'),(7,11,7,2,'2024-05-25 20:44:48',140.00,'Özgür,9, 35120, Karabağlar/Erdemli, Türkiye','completed'),(8,12,23,3,'2024-05-25 20:44:48',210.00,'Yıldırım Mah., Atatürk Cad., No: 45, Zeytinburnu/Ankara, Türkiye','pending'),(9,13,11,11,'2024-05-25 20:44:48',350.00,'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye','completed'),(10,14,11,11,'2024-05-25 20:44:48',120.00,'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul','pending'),(11,16,14,17,'2024-05-25 20:44:48',230.00,'Karabörk Köyü,35, 23852, Kovancilar/Mugla','completed'),(12,18,9,3,'2024-05-25 20:44:48',90.00,'Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye','completed'),(13,19,18,3,'2024-05-25 20:44:48',60.00,'Karabucak,12, 7570, Demre/Antakya, Türkiye','completed'),(14,20,18,6,'2024-05-25 20:44:48',270.00,'Karabucak,12, 7570, Demre/Antakya, Türkiye','completed'),(15,22,19,1,'2024-05-25 20:44:48',200.00,'Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye','completed'),(16,26,2,21,'2024-05-25 20:44:48',100.00,'Küllüce Köyü,30, 24802, Tercan/Afyon, Türkiye','completed'),(17,27,15,7,'2024-05-25 20:44:48',250.00,'Alaçam,31, 55850, Kavak/Izmit, Türkiye','completed'),(18,29,19,12,'2024-05-25 20:44:48',320.00,'Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye','pending'),(19,31,11,42,'2024-05-25 20:44:48',120.00,'Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye','completed'),(20,42,33,13,'2024-05-25 20:44:48',230.00,'Çamlık Mah., Mehmet Akif Ersoy Cad., No: 5, Karabağlar/Kocaeli, Türkiye','completed'),(21,44,37,42,'2024-05-25 20:44:48',200.00,'Gazi Mah., Zafer Cad., No: 11, Osmangazi/Kütahya, Türkiye','pending');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_transaction_insert_update_seller_info` BEFORE INSERT ON `transactions` FOR EACH ROW BEGIN
    -- Check if the transaction status is 'completed' before insertion
    IF NEW.status = 'completed' THEN
        -- Attempt to insert or update SellerInformation
        INSERT INTO SellerInformation (seller_id, total_sales)
        VALUES (NEW.seller_id, 1)
        ON DUPLICATE KEY UPDATE
        total_sales = total_sales + 1;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_product_status_on_transaction` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    DECLARE product_status VARCHAR(20);

    -- Determine the product status based on transaction status
    IF NEW.status = 'completed' THEN
        SET product_status = 'sold';
    ELSEIF NEW.status = 'pending' THEN
        SET product_status = 'reserved';
    END IF;

    -- Update the product status in Products table if product_status is set
    IF product_status IS NOT NULL THEN
        UPDATE Products
        SET status = product_status
        WHERE product_id = NEW.product_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `verify_seller_after_sale` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    -- Check if the transaction status is 'completed'
    IF NEW.status = 'completed' THEN
        -- Check if the seller has completed 3 or more transactions
        IF (
            SELECT COUNT(*)
            FROM Transactions
            WHERE seller_id = NEW.seller_id AND status = 'completed'
        ) >= 3 THEN
            -- Update the seller's verification status
            UPDATE SellerInformation
            SET verification_status = 'verified'
            WHERE seller_id = NEW.seller_id;
        ELSE
            -- Update the seller's verification status to 'unverified' if not enough transactions
            UPDATE SellerInformation
            SET verification_status = 'unverified'
            WHERE seller_id = NEW.seller_id;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `address` text,
  `phone` varchar(20) DEFAULT NULL,
  `date_joined` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'AltayUygur','altayugur@gmail.com','5xng4c','Altay Uygur','Özkan Köyü,14, 3602, Emirdağ/ Afyonkarahisar, Türkiye','+904886225300','2024-05-25 20:44:48',NULL),(2,'YalçinNazmi','yalcinnazmi@gmail.com','wqcuqa','Yalçin Nazmi','Küllüce Köyü,30, 24802, Tercan/Afyon, Türkiye','+904888951370','2024-05-25 20:44:48',NULL),(3,'BeyzaVolkan','beyzavolkan@gmail.com','fzy8dm','Beyza Volkan','Mersin,20, 61300, Akçaabat/Adapazari, Türkiye','+908504313568','2024-05-25 20:44:48',NULL),(4,'ÖztürkToker','ozturktoker@gmail.com','5yd8ju','Öztürk Toker','Dalbahçe,16, 55500, Çarşamba/Bandirma, Türkiye','+903327217643','2024-05-25 20:44:48',NULL),(5,'KadirBayrak','kadirbayrak@gmail.com','skbksp','Kadir Bayrak','Çivi Köyü,17, 5000, Merkez/Bursa, Türkiye','+903240833298','2024-05-25 20:44:48',NULL),(6,'IrmakÜzümcü','irmakuzumcu@gmail.com','bz8s9n','Irmak Üzümcü','Gümüşsuyu Mah.,9, 2802, Samsat/Bursa, Türkiye','+904880699480','2024-05-25 20:44:48',NULL),(7,'EserAtakan','eseratakan@gmail.com','4w9r3d','Eser Atakan','Özgür,9, 35120, Karabağlar/Erdemli, Türkiye','+905337942852','2024-05-25 20:44:48',NULL),(8,'MirayTop','miraytop@gmail.com','pt6kef','Miray Top','Haciibrahim Köyü,15, 37502, İnebolu/Burdur, Türkiye','+905473755226','2024-05-25 20:44:48',NULL),(9,'EvrenKobal','evrenkobal@gmail.com','kjh2yg','Evren Kobal','Taşbaşi,22, 42630, Bozkir/Bolu, Türkiye','+905067680461','2024-05-25 20:44:48',NULL),(10,'IpekHamdi','ipekhamdi@gmail.com','jherva','Ipek Hamdi','Seydiköy Köyü,23, 43270, Merkez/Istanbul, Türkiye','+904585564041','2024-05-25 20:44:48',NULL),(11,'SanemAyvaz','sanemayvaz@gmail.com','57jxap','Sanem Ayvaz','Yukariçayircik Köyü,27, 37402, Taşköprü/Istanbul, Türkiye','+904880005663','2024-05-25 20:44:48',NULL),(12,'KaraErdinç','karaerdinc@gmail.com','rwqmap','Kara Erdinç','Dez,6, 30110, Merkez/Didim, Türkiye','+902522013221','2024-05-25 20:44:48',NULL),(13,'EsenIrmak','esenirmak@gmail.com','27brgt','Esen Irmak','Abdulvehap Küfrevi Mah.,29, 4500, Patnos/Istanbul, Türkiye','+908111998354','2024-05-25 20:44:48',NULL),(14,'CivanÖrnek','civanornek@gmail.com','ewm9vv','Civan Örnek','Karabörk Köyü,35, 23852, Kovancilar/Mugla, Türkiye','+902466758479','2024-05-25 20:44:48',NULL),(15,'BesteHeper','bestehepe@gmail.com','vzxh6k','Beste Heper','Alaçam,31, 55850, Kavak/Izmit, Türkiye','+905948334598','2024-05-25 20:44:48',NULL),(16,'BanuGürsu','banugürsu@gmail.com','57b2c5','Banu Gürsu','Aşağitoklu Köyü,20, 4802, Taşliçay/Edirne, Türkiye','+903763334278','2024-05-25 20:44:48',NULL),(17,'EsraCaner','esracaner@gmail.com','5mtmyu','Esra Caner','Karagöz,8, 44210, Battalgazi/Yalova, Türkiye','+904581921338','2024-05-25 20:44:48',NULL),(18,'KadirSözen','kadirsozen@gmail.com','8u39nz','Kadir Sözen','Karabucak,12, 7570, Demre/Antakya, Türkiye','+904666623539','2024-05-25 20:44:48',NULL),(19,'MetinAlkan','metinalkan@gmail.com','jeptnz','Metin Alkan','Saribaba Köyü,27, 29832, Kürtün/Tokat, Türkiye','+905551144780','2024-05-25 20:44:48',NULL),(20,'BerilKoçak','berilkocak@gmail.com','nzt4tm','Beril Koçak','Civreyil,32, 57402, Ayancik/Istanbul, Türkiye','+904240959892','2024-05-25 20:44:48',NULL),(21,'GamzeÖrnek','gamzeornek@gmail.com','jdycmd','Gamze Örnek','Tabakhane,14, 16900, Yenişehir/Canakkale, Türkiye','+905430687682','2024-05-25 20:44:48',NULL),(22,'AhmetKara','ahmet.kara@gmail.com','t9l27w','Ahmet Kara','Kıbrıs Cad., No: 23, Dikili/Balıkesir, Türkiye','+905553324567','2024-05-25 20:44:48',NULL),(23,'AyşeYılmaz','ayse.yilmaz@gmail.com','72gptd','Ayşe Yılmaz','Yıldırım Mah., Atatürk Cad., No: 45, Zeytinburnu/Ankara, Türkiye','+905444786123','2024-05-25 20:44:48',NULL),(24,'MehmetDemir','mehmet.demir@gmail.com','e94kft','Mehmet Demir','Fatih Mah., Gazi Cad., No: 78, Üsküdar/Ankara, Türkiye','+905568975432','2024-05-25 20:44:48',NULL),(25,'FatmaÖztürk','fatma.ozturk@gmail.com','p5x8sq','Fatma Öztürk','Atatürk Bulv., No: 12, Bornova/Izmir, Türkiye','+905512367890','2024-05-25 20:44:48',NULL),(26,'MustafaYıldız','mustafa.yildiz@gmail.com','qf5dp2','Mustafa Yıldız','Cemil Meriç Cad., No: 34, Çankaya/Adana, Türkiye','+905323476589','2024-05-25 20:44:48',NULL),(27,'ZeynepKılıç','zeynep.kilic@gmail.com','64m9nr','Zeynep Kılıç','Yavuz Selim Mah., 1003 Sok., No: 7, Çorlu/Bursa, Türkiye','+905463218745','2024-05-25 20:44:48',NULL),(28,'EmineÖzdemir','emine.ozdemir@gmail.com','w7pjsq','Emine Özdemir','Bahçelievler Mah., Atatürk Cad., No: 56, Kepez/Ankara, Türkiye','+905330945678','2024-05-25 20:44:48',NULL),(29,'AliYavuz','ali.yavuz@gmail.com','xvk3gp','Ali Yavuz','Barbaros Mah., Çınar Cad., No: 89, Maltepe/Kayseri, Türkiye','+905554789012','2024-05-25 20:44:48',NULL),(30,'HavvaAydın','havva.aydin@gmail.com','k6g4mx','Havva Aydın','Yunus Emre Cad., No: 21, Sarıyer/Balıkesir, Türkiye','+905418905432','2024-05-25 20:44:48',NULL),(31,'MuratArslan','murat.arslan@gmail.com','t4d7sw','Murat Arslan','Güzel Sanatlar Mah., Ali İhsan Göğüş Cad., No: 33, Zeytinburnu/Manisa, Türkiye','+905547834567','2024-05-25 20:44:48',NULL),(32,'HaticeKurt','hatice.kurt@gmail.com','f9msq2','Hatice Kurt','Mimarsinan Mah., 2021 Sok., No: 10, Bağcılar/Konya, Türkiye','+905549876543','2024-05-25 20:44:48',NULL),(33,'İbrahimGüneş','ibrahim.gunes@gmail.com','b6z5nf','İbrahim Güneş','Çamlık Mah., Mehmet Akif Ersoy Cad., No: 5, Karabağlar/Kocaeli, Türkiye','+905558762349','2024-05-25 20:44:48',NULL),(34,'SalihaŞahin','saliha.sahin@gmail.com','t8jzvq','Saliha Şahin','Aşağı Mah., Atatürk Bulv., No: 22, Muratpaşa/Elazığ, Türkiye','+905523467890','2024-05-25 20:44:48',NULL),(35,'YusufAvcı','yusuf.avci@gmail.com','p6mdtn','Yusuf Avcı','İstasyon Mah., 2023 Sok., No: 15, Merkez/Gaziantep, Türkiye','+905531234567','2024-05-25 20:44:48',NULL),(36,'SultanKaya','sultan.kaya@gmail.com','m8b4jd','Sultan Kaya','Kurtuluş Mah., 1080 Sok., No: 30, İzmit/Aydın, Türkiye','+905536789012','2024-05-25 20:44:48',NULL),(37,'OsmanBulut','osman.bulut@gmail.com','7prkxm','Osman Bulut','Gazi Mah., Zafer Cad., No: 11, Osmangazi/Kütahya, Türkiye','+905547098765','2024-05-25 20:44:48',NULL),(38,'HafizePolat','hafize.polat@gmail.com','n5gj2t','Hafize Polat','Maraşal Fevzi Çakmak Mah., Zübeyde Hanım Cad., No: 45, Karşıyaka/Sakarya, Türkiye','+905541234567','2024-05-25 20:44:48',NULL),(39,'İsmailÖzkan','ismail.ozkan@gmail.com','t3vrj9','İsmail Özkan','Balkan Mah., Atatürk Bulv., No: 8, Nilüfer/Çorum, Türkiye','+905550987654','2024-05-25 20:44:48',NULL),(40,'YeterKoç','yeter.koc@gmail.com','x5f7mr','Yeter Koç','Erenler Mah., Gaziantep Cad., No: 14, Seyhan/Artvin, Türkiye','+905561234567','2024-05-25 20:44:48',NULL),(41,'MustafaAksoy','mustafa.aksoy@gmail.com','n2kx8v','Mustafa Aksoy','Büyükşehir Mah., 3026 Sok., No: 25, Etimesgut/Trabzon, Türkiye','+905548901234','2024-05-25 20:44:48',NULL),(42,'AynurDemirci','aynur.demirci@gmail.com','9m6p3t','Aynur Demirci','Bilge Mah., Mustafa Kemal Paşa Cad., No: 28, Mamak/Sivas, Türkiye','+905548765432','2024-05-25 20:44:48',NULL),(43,'YusufBudak','yusuf.budak@gmail.com','b9kx8z','Yusuf Budak','Bahçelievler Mah., Turgut Reis Cad., No: 16, Akşehir/Adıyaman, Türkiye','+905557654321','2024-05-25 20:44:48',NULL),(44,'HüseyinAslan','huseyin.aslan@gmail.com','m3kv75','Hüseyin Aslan','Fatih Mah., Mimar Sinan Cad., No: 12, Gürpınar/Afyonkarahisar, Türkiye','+905558741515','2024-05-25 20:44:48',NULL),(45,'NurKoç','nur.koc@gmail.com','4w9s3t','Nur Koç','Atatürk Mah., İnönü Cad., No: 7, Esenyurt/Trabzon, Türkiye','+905556789012','2024-05-25 20:44:48',NULL),(46,'AliÖztürk','ali.ozturk@gmail.com','k7b3zm','Ali Öztürk','Çamlıca Mah., Cumhuriyet Cad., No: 10, Ümraniye/Mardin, Türkiye','+905523456789','2024-05-25 20:44:48',NULL),(47,'NecmiyeYılmaz','necmiye.yilmaz@gmail.com','z5m9nx','Necmiye Yılmaz','Merkez Mah., Akasya Sok., No: 22, Beyoğlu/Zonguldak, Türkiye','+905541234567','2024-05-25 20:44:48',NULL),(48,'RamazanKaya','ramazan.kaya@gmail.com','t6n7vk','Ramazan Kaya','Feke Mah., Gültepe Cad., No: 15, Çaycuma/Aksaray, Türkiye','+905556789012','2024-05-25 20:44:48',NULL),(49,'RabiaŞahin','rabia.sahin@gmail.com','p8x5mk','Rabia Şahin','Güzelyurt Mah., Talatpaşa Cad., No: 9, Ümraniye/Karaman, Türkiye','+905536789012','2024-05-25 20:44:48',NULL),(50,'BurakKurt','burak.kurt@gmail.com','m9p6sc','Burak Kurt','Yenidoğan Mah., Gazi Cad., No: 25, Çubuk/Kastamonu, Türkiye','+905550987654','2024-05-25 20:44:48',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_last_login` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
    IF NEW.last_login IS NOT NULL THEN
        SET NEW.last_login = CURRENT_TIMESTAMP;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'engin_esra'
--

--
-- Dumping routines for database 'engin_esra'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-25 20:45:09

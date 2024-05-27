/*
	IS 503 - Spring 2024
	Term project queries
	Student names: Engin Kılınç
				   Esra Şekerci
	==================================================================

*/

/*
	Complex query 1 - Find Verified Sellers with High Ratings and Active Listings
	Explanation: This query identifies verified sellers with high ratings (over 2.5) who have at least one active listing. 
    It uses JOIN to combine Users, SellerInformation, and Products, and utilizes EXISTS to filter sellers with 
    active listings.
*/

SELECT u.user_id, u.username, s.rating, COUNT(p.product_id) AS active_listings
FROM Users u
JOIN SellerInformation s ON u.user_id = s.seller_id
JOIN Products p ON u.user_id = p.user_id
WHERE s.verification_status = 'verified'
  AND s.rating >= 2.5
  AND EXISTS (
      SELECT 1
      FROM Products p2
      WHERE p2.user_id = u.user_id
        AND p2.status = 'available'
  )
GROUP BY u.user_id, u.username, s.rating;

/*
	Complex query 2 - Products Sold by Top-Selling Sellers with Specific Brands
	Explanation: This query retrieves details of products sold by top-selling sellers for specific brands. 
    It uses JOIN to combine Products, Transactions, Brands, and SellerInformation, and employs IN to filter sellers 
    with high total sales.
*/

SELECT p.product_id, p.product_name, p.price, b.brand_name, s.total_sales
FROM Products p
JOIN Transactions t ON p.product_id = t.product_id
JOIN Brands b ON p.brand_id = b.brand_id
JOIN SellerInformation s ON t.seller_id = s.seller_id
WHERE t.status = 'completed'
  AND s.total_sales IN (
      SELECT seller_id
      FROM SellerInformation
      WHERE total_sales >= 3
  )
  AND b.brand_name LIKE '%Defacto%';


/*
	Complex query 3 - Active Buyers with Reviews
	Explanation: This query identifies active buyers who have provided a significant number of high-rated reviews
    (rating 3 and above) on products. It uses joins to combine the Users, Transactions, Reviews, and Products tables.
*/

SELECT u.user_id, u.username, COUNT(r.review_id) AS review_count
FROM Users u
JOIN Transactions t ON u.user_id = t.buyer_id
JOIN Products p ON t.product_id = p.product_id
JOIN Reviews r ON t.product_id = r.product_id AND t.buyer_id = r.user_id
WHERE r.rating >= 3
GROUP BY u.user_id, u.username
HAVING COUNT(r.review_id) > 1;


/*
	Complex query 4 - Sellers with No Completed Transactions
	Explanation: This query identifies sellers who have no completed transactions but have listed products matching 
    a certain keyword. It uses JOIN to combine Users and Products, and employs NOT EXISTS to filter sellers without 
    completed transactions.
*/

SELECT u.user_id, u.username, COUNT(p.product_id) AS listed_products
FROM Users u
JOIN Products p ON u.user_id = p.user_id
WHERE p.description LIKE '%pantolon%'
  AND NOT EXISTS (
      SELECT 1
      FROM Transactions t
      WHERE t.seller_id = u.user_id
        AND t.status = 'completed'
  )
GROUP BY u.user_id, u.username;

/*
	==================================================================
	
	View creation query
	Explanation: This view aggregates various metrics for the dashboard analytics of the e-commerce application.
	- registration_month: Month of user registration formatted as YYYY-MM.
	- new_users_count: Total count of new users registered in each month.
	- total_products: Total number of products available in the system.
	- pending_transactions: Count of transactions that are currently pending.
	- completed_transactions: Count of transactions that have been successfully completed.
	- avg_product_rating: Average rating across all products based on user reviews.
	- total_reviews: Total number of reviews submitted by users.
	- top_user_name: Full name of the user with the highest sales.
	- top_user_total_sales: Total sales amount of the top user.
	- avg_seller_rating: Average rating of sellers based on their transaction history.
*/

CREATE VIEW DashboardAnalytics AS
SELECT
    DATE_FORMAT(u.date_joined, '%Y-%m') AS registration_month,
    COUNT(*) AS new_users_count,
    (SELECT COUNT(*) FROM Products) AS total_products,
    (SELECT COUNT(*) FROM Transactions WHERE status = 'pending') AS pending_transactions,
    (SELECT COUNT(*) FROM Transactions WHERE status = 'completed') AS completed_transactions,
    AVG(r.rating) AS avg_product_rating,
    (SELECT COUNT(*) FROM Reviews) AS total_reviews,
    MAX(u.full_name) AS top_user_name,
    MAX(s.total_sales) AS top_user_total_sales,
    AVG(s.rating) AS avg_seller_rating
FROM
    Users u
LEFT JOIN Transactions t ON u.user_id = t.buyer_id
LEFT JOIN Reviews r ON u.user_id = r.user_id
LEFT JOIN SellerInformation s ON u.user_id = s.seller_id
GROUP BY
    registration_month
ORDER BY
    registration_month DESC;

/*
	==================================================================
	
	Trigger creation query 1
	Explanation: This SQL trigger ('before_transaction_insert_update_seller_info') is designed to execute automatically before
    a new row is inserted into the `Transactions` table. It ensures that the `SellerInformation` table is updated accordingly 
    if the transaction status is 'completed'.
*/

DELIMITER //

CREATE TRIGGER before_transaction_insert_update_seller_info
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    -- Check if the transaction status is 'completed' before insertion
    IF NEW.status = 'completed' THEN
        -- Attempt to insert or update SellerInformation
        INSERT INTO SellerInformation (seller_id, total_sales)
        VALUES (NEW.seller_id, 1)
        ON DUPLICATE KEY UPDATE
        total_sales = total_sales + 1;
    END IF;
END //

DELIMITER ;

/*
	Trigger control queries 1
*/

-- Select query to check total sales before inserting a new transaction.
SELECT * FROM SellerInformation;

-- Insert query to trigger the update of total sales. 
-- Here, the number of total sales for seller_id=13 increased.
-- Furthermore, the new seller_id=36 is added since there is no record for him/her beforehand.
INSERT INTO Transactions (product_id, buyer_id, seller_id, price, shipping_address, status) 
VALUES (6, 40, 13, 220.00, 'Büyükşehir Mah., 3026 Sok., No: 25, Etimesgut/Trabzon, Türkiye', 'completed'),
(50, 5, 36, 100.00, 'Çivi Köyü,17, 5000, Merkez/Bursa, Türkiye', 'completed');

-- Select query to check total sales after inserting a new transaction.
SELECT * FROM SellerInformation;

/*  
	Trigger creation query 2
	Explanation: This SQL trigger ('update_product_status_on_transaction') is designed to execute automatically after a new row is inserted 
    into the `Transactions` table. It ensures that the status of a product is updated in the `Products` table based on 
    the status of the transaction.
*/

DELIMITER //

CREATE TRIGGER update_product_status_on_transaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
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
END //

DELIMITER ;

/*
	Trigger control queries 2
*/

-- Select query to check product status before inserting a new transaction.
SELECT * FROM Products WHERE product_id IN (48, 49);

-- Insert query to trigger the update of product status.
INSERT INTO Transactions (product_id, buyer_id, seller_id, price, shipping_address, status) 
VALUES (48, 8, 29, 150.00, 'Haciibrahim Köyü,15, 37502, İnebolu/Burdur, Türkiye', 'completed'),
(49, 8, 20, 400.00, 'Haciibrahim Köyü,15, 37502, İnebolu/Burdur, Türkiye', 'pending');

-- Select query to check product status after inserting a new transaction.
-- According to the transaction status we see that the product status are changed.
SELECT * FROM Products WHERE product_id IN (48, 49);

/*  
	Trigger creation query 3
	Explanation: This SQL trigger ('after_review_insert') is designed to execute automatically after a new row is inserted into
    the `Reviews`table. It ensures that the average rating of a seller is updated in the `SellerInformation` table based on 
    the reviews of products associated with completed transactions.
*/

DELIMITER //

CREATE TRIGGER after_review_insert
AFTER INSERT ON Reviews
FOR EACH ROW
BEGIN
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
END //

DELIMITER ;

/*
	Trigger control queries 3
*/

-- Select query to check seller rating before inserting a new review.
SELECT * FROM SellerInformation where seller_id=13;

-- Insert query to trigger the update of seller rating.
INSERT INTO Reviews (product_id, user_id, rating, comment) 
VALUES (6, 40, 4, 'Bu fiyata gayet uygun bir kazaktı ancak renginden emin olamadım.');

-- Select query to check seller rating after inserting a new review.
SELECT * FROM SellerInformation where seller_id=13;

/*  
	Trigger creation query 4
	Explanation: This SQL trigger ('enforce_review_on_completed_transaction') is designed to enforce that reviews can only be added 
    for products where there is a completed transaction by the buyer. Additionally, it prevents multiple reviews for the same 
    product by the same buyer.
*/

DELIMITER //

CREATE TRIGGER enforce_review_on_completed_transaction
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
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
END //

DELIMITER ;

/*
	Trigger control queries 4
*/

-- Select query to check reviews before inserting a duplicate review.
SELECT * FROM Reviews;

-- If no transaction found or status is not completed, raise an error
INSERT INTO Reviews (product_id, user_id, rating, comment) 
VALUES (40, 8, 1, 'Ürünü hiç beğenmedim');   -- Error Code: 1644. Cannot add review: No transaction found for this product

-- Check if the product already has a review from the buyer
INSERT INTO Reviews (product_id, user_id, rating, comment) 
VALUES (6, 40, 4, 'Satıcıyı tekrar puanlamak istedim.'); -- Error Code: 1644. Cannot add review: Already reviewed this product


/*  
	Trigger creation query 5
	Explanation: This SQL trigger (`update_last_login`) is designed to update the `last_login` field to the current timestamp 
    whenever the `Users` table is updated and the `last_login` field is not NULL.
*/

DELIMITER //

CREATE TRIGGER update_last_login
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NEW.last_login IS NOT NULL THEN
        SET NEW.last_login = CURRENT_TIMESTAMP;
    END IF;
END //

DELIMITER ;

/*
	Trigger control queries 5
*/

-- Select query to check last login date before updating.
SELECT user_id, username, last_login FROM Users WHERE user_id = 1;

-- Update query to trigger the last login update.
UPDATE Users SET last_login = CURRENT_TIMESTAMP WHERE user_id = 1;

-- Select query to check last login date after updating.
SELECT user_id, username, last_login FROM Users WHERE user_id = 1;


/*  
	Trigger creation query 6
	Explanation:This SQL trigger ('verify_seller_after_sale') fires after an insertion into the Transaction table. 
    It checks if a new transaction is marked as 'completed'. If so, it counts the number of completed transactions for 
    the seller and updates the verification status of the seller if they have completed 3 or more transactions.
*/

DELIMITER $$

CREATE TRIGGER verify_seller_after_sale
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
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
END $$

DELIMITER ;

/*
	Trigger control queries 6
*/

-- Select query to see seller verification status.
SELECT * FROM SellerInformation WHERE seller_id=21;

-- Update query to trigger verification status of the seller.
INSERT INTO Transactions (product_id, buyer_id, seller_id, price, shipping_address, status) 
VALUES (26, 44, 21, 10.00, 'Fatih Mah., Mimar Sinan Cad., No: 12, Gürpınar/Afyonkarahisar, Türkiye', 'completed');

-- After completing 3 sales, seller_id=21 become verified
SELECT * FROM SellerInformation WHERE seller_id=21;



DELIMITER //

CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM Subscribers
    WHERE SubscriberName = subName;

    IF cnt = 0 THEN
        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        VALUES ((SELECT IFNULL(MAX(SubscriberID),0)+1 FROM Subscribers), subName, CURDATE());
    END IF;
END //

DELIMITER ;
CALL AddSubscriberIfNotExists('New User');
SELECT * FROM Subscribers;